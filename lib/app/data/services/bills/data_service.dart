import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class DataService {
  static Map<String, dynamic> _header() => {
        "Content-Type": "application/json",
        "MerchantId": "nitrobills",
        "Authorization":
            "Bearer ${Get.find<UserAccountController>().account.value.secrets.giftbillsSecret}",
      };

  static String get _baseUrl =>
      Get.find<UserAccountController>().account.value.secrets.giftbillsUrl;

  static AsyncOrError<List<MobileServiceProvider>> getMobileProiders() async {
    TypeOrError<dio.Response> response =
        await HttpService.get("$_baseUrl/internet", header: _header());

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        Map responseData = response.right.data;
        if ((responseData["success"] is bool) && responseData["success"]) {
          List<Map> data = List<Map>.from(responseData["data"]);
          List<MobileServiceProvider> providers = [];
          for (var dt in data) {
            String prov = dt["provider"];
            if (MobileServiceProvider.allDataMap.containsKey(prov)) {
              providers.add(MobileServiceProvider.allDataMap[prov]!);
            }
          }
          return Right(providers);
        } else {
          return Left(AppError(responseData["message"]));
        }
      } else {
        return Left(AppError(response.right.statusMessage ?? ""));
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<List<GbDataPlans>> getDataPlans(String provider) async {
    TypeOrError<dio.Response> response = await HttpService.get(
        "$_baseUrl/internet/plans/$provider",
        header: _header());

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        Map responseData = response.right.data;
        if ((responseData["success"] is bool) && responseData["success"]) {
          List<Map> data = List<Map>.from(responseData["data"]);
          List<GbDataPlans> providers =
              data.map<GbDataPlans>((pr) => GbDataPlans.fromJson(pr)).toList();
          return Right(providers);
        } else {
          return Left(AppError(responseData["message"]));
        }
      } else {
        return Left(AppError(response.right.statusMessage ?? ""));
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<Transaction> buy(DataBill bill) async {
    Map payload = {
      "provider": bill.provider.id,
      "number": bill.codeNumber,
      "amount": "${bill.amount}",
      "plan": bill.plan.id,
      // if (bill.beneficiaryId != null) "beneficiary_id": bill.beneficiaryId,
    };

    TypeOrError<dio.Response> response = await HttpService.post(
        "${NbUtils.baseUrl}/api/bills/data/", payload,
        header: {
          "Content-Type": "application/json",
          "Authorization":
              "Token ${Get.find<UserAccountController>().authToken.value}",
        });

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        Transaction tran =
            Transaction.fromJson(response.right.data["transaction"]);
        return Right(tran);
      } else if (response.right.data.containsKey("msg")) {
        String msg = response.right.data["msg"];
        return Left(AppError(msg));
      } else {
        return Left(
          AppError(HttpService.stringFromMap(response.right.data)),
        );
      }
    } else {
      return Left(response.left);
    }
  }
}

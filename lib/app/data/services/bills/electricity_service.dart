import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_electric_data.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class ElectricityService {
  static Map<String, dynamic> _header() => {
        "Content-Type": "application/json",
        "MerchantId": "nitrobills",
        "Authorization":
            "Bearer ${Get.find<UserAccountController>().account.value.secrets.giftbillsSecret}",
      };

  static String get _baseUrl =>
      Get.find<UserAccountController>().account.value.secrets.giftbillsUrl;

  static AsyncOrError<List<ElectricityServiceProvider>>
      getElectricityProviders() async {
    TypeOrError<dio.Response> response =
        await HttpService.get("$_baseUrl/electricity", header: _header());

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        Map responseData = response.right.data;
        if ((responseData["success"] is bool) && responseData["success"]) {
          List<Map> data = List<Map>.from(responseData["data"]);
          List<ElectricityServiceProvider> providers = [];
          for (var dt in data) {
            String prov = dt["provider"];
            if (ElectricityServiceProvider.allDataMap.containsKey(prov)) {
              ElectricityServiceProvider currentProv =
                  ElectricityServiceProvider.allDataMap[prov]!;
              currentProv.minAmount = double.tryParse(dt["minAmount"]) ?? 0;
              providers.add(currentProv);
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

  static AsyncOrError<GbElectricData> validateCustomer(
      String provider, String customerId) async {
    Map<String, dynamic> payload = {
      "provider": provider,
      "customerId": customerId
    };
    TypeOrError<dio.Response> response = await HttpService.post(
        "$_baseUrl/betting/validate", payload,
        header: _header());

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        Map responseData = response.right.data;
        if ((responseData["success"] is bool) && responseData["success"]) {
          return Right(GbElectricData.fromJson(responseData));
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

  static AsyncOrError<Transaction> buy(ElectricityBill bill) async {
    Map payload = {
      "provider": bill.provider.id,
      "number": bill.codeNumber,
      "amount": "${bill.amount}",
      // if (bill.beneficiaryId != null) "beneficiary_id": bill.beneficiaryId,
    };

    TypeOrError<dio.Response> response = await HttpService.post(
        "${NbUtils.baseUrl}/api/bills/electricity/", payload,
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

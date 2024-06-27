import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/pages/autopayments/models/autopay.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AutopayService {
  static Map<String, dynamic> _header() => {
        "Content-Type": "application/json",
        "Authorization":
            "Token ${Get.find<UserAccountController>().authToken.value}",
      };

  static AsyncOrError<List<Autopay>> getAutopay() async {
    TypeOrError<dio.Response> response = await HttpService.get(
        "${NbUtils.baseUrl}/api/data/autopay/",
        header: _header());

    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        List<Map> data = List<Map>.from(responseData["data"]);
        List<Autopay> beneficiaries = data
            .map<Autopay>(
              (Map json) => Autopay.fromJson(Map<String, dynamic>.from(json)),
            )
            .toList();
        return Right(beneficiaries);
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(AppError(msg));
      } else {
        return Left(
          AppError(HttpService.stringFromMap(responseData)),
        );
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<Autopay> createAutopay(Autopay autopay) async {
    Map<String, dynamic> payload = {
      "name": autopay.name,
      "transaction_type": autopay.serviceType.toServerString,
      "service_provider": autopay.serviceProvider,
      "number": autopay.number,
      "amount_plan": autopay.amountPlan,
      "period": autopay.period,
      "custom_days": autopay.customDays,
      "end_date": autopay.endDate.toIso8601String()
    };

    TypeOrError<dio.Response> response = await HttpService.post(
        "${NbUtils.baseUrl}/api/data/autopay/create/", payload,
        header: _header());

    if (response.isRight) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.right.data);
      if ((response.right.statusCode == 200) ||
          (response.right.statusCode == 201)) {
        return Right(Autopay.fromJson(responseData));
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(AppError(msg));
      } else {
        return Left(
          AppError(HttpService.stringFromMap(responseData)),
        );
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<Null> deleteAutopay(int id) async {
    TypeOrError<dio.Response> response = await HttpService.delete(
        "${NbUtils.baseUrl}/api/data/autopay/delete/$id/", null,
        header: _header());
    if (response.isRight) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.right.data);
      if (response.right.statusCode == 200) {
        return const Right(null);
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(AppError(msg));
      } else {
        return Left(
          AppError(HttpService.stringFromMap(responseData)),
        );
      }
    } else {
      return Left(response.left);
    }
  }
}

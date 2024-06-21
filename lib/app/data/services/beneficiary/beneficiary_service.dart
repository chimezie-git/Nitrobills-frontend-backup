import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class BeneficiaryService {
  static Map<String, dynamic> _header() => {
        "Content-Type": "application/json",
        "Authorization":
            "Token ${Get.find<UserAccountController>().authToken.value}",
      };

  static AsyncOrError<List<Beneficiary>> getBeneficiary() async {
    TypeOrError<dio.Response> response = await HttpService.get(
        "${NbUtils.baseUrl}/api/data/beneficiaries/",
        header: _header());

    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        List<Map> data = List<Map>.from(responseData["data"]);
        List<Beneficiary> beneficiaries = data
            .map<Beneficiary>(
              (Map json) =>
                  Beneficiary.fromJson(Map<String, dynamic>.from(json)),
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

  static AsyncOrError<Beneficiary> createBeneficiary(
    String name,
    ServiceTypesEnum serviceType,
    AbstractServiceProvider provider,
    String number,
  ) async {
    Map<String, dynamic> payload = {
      "name": name,
      "user_code": number,
      "provider": provider.id,
      "transaction_type": serviceType.toServerString,
    };

    TypeOrError<dio.Response> response = await HttpService.post(
        "${NbUtils.baseUrl}/api/data/beneficiaries/create/", payload,
        header: _header());

    if (response.isRight) {
      Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.right.data);
      if ((response.right.statusCode == 200) ||
          (response.right.statusCode == 201)) {
        return Right(Beneficiary.fromJson(responseData));
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

  static AsyncOrError<Null> deleteBeneficiary(
    int id,
  ) async {
    TypeOrError<dio.Response> response = await HttpService.delete(
        "${NbUtils.baseUrl}/api/data/beneficiaries/delete/$id", null,
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

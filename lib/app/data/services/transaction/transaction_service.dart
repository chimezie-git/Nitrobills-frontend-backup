import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class TransactionService {
  static Map<String, dynamic> _header() => {
        "Content-Type": "application/json",
        "Authorization":
            "Token ${Get.find<UserAccountController>().authToken.value}",
      };

  static AsyncOrError<List<Transaction>> getTransactions() async {
    TypeOrError<dio.Response> response = await HttpService.get(
        "${NbUtils.baseUrl}/api/data/transactions/",
        header: _header());

    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        List<Map> data = List<Map>.from(responseData["data"]);
        List<Transaction> beneficiaries = data
            .map<Transaction>(
              (Map json) =>
                  Transaction.fromJson(Map<String, dynamic>.from(json)),
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
}

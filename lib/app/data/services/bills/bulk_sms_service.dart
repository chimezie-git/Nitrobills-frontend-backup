import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class BulkSmsService {
  static AsyncOrError<Transaction> buy(BulkSMSBill bill) async {
    Map payload = {
      "sender_name": bill.name,
      "message": bill.message,
      "numbers": bill.contacts,
      // if (bill.beneficiaryId != null) "beneficiary_id": bill.beneficiaryId,
    };

    TypeOrError<dio.Response> response = await HttpService.post(
        "${NbUtils.baseUrl}/api/bills/bulk_sms/", payload,
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

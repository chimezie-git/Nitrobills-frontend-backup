import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/services/transaction/transaction_service.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class TransactionsController extends GetxController {
  final RxList<Transaction> transactions = RxList<Transaction>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);
  final RxBool loaded = RxBool(false);

  Future initialize() async {
    if (!loaded.value) {
      status.value = LoaderEnum.loading;
      final result = await TransactionService.getTransactions();
      if (result.isRight) {
        transactions.value = result.right;
        status.value = LoaderEnum.success;
        loaded.value = true;
      } else {
        status.value = LoaderEnum.failed;
        NbToast.error(result.left.message);
      }
      update();
    }
  }

  Future reload({bool showLoader = false}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await TransactionService.getTransactions();
    if (result.isRight) {
      transactions.value = result.right;
      status.value = LoaderEnum.success;
      loaded.value = true;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(result.left.message);
    }
    update();
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    update();
  }
}

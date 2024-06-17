import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/user_account.dart';
import 'package:nitrobills/app/data/models/virtual_accounts/customer_model.dart';
import 'package:nitrobills/app/data/services/account/user_account_service.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class UserAccountController extends GetxController {
  final Rxn<CustomerModel> customer = Rxn<CustomerModel>(null);
  late final Rx<UserAccount> account;
  final RxDouble balance = RxDouble(0);
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);
  final RxString authToken = RxString("");
  final RxBool loaded = RxBool(false);

  Future initialize([bool force = false]) async {
    if (!loaded.value) {
      //load data and set account value
      status.value = LoaderEnum.loading;
      final result = await UserAccountService.getAccount();
      if (result.isRight) {
        account = Rx<UserAccount>(result.right);
        status.value = LoaderEnum.success;
        loaded.value = true;
      } else {
        status.value = LoaderEnum.failed;
        NbToast.error(result.left.message);
      }
    }
  }

  Future reload() async {
    final result = await UserAccountService.getAccount();
    if (result.isRight) {
      account.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(result.left.message);
    }
  }

  double get totalAmount =>
      account.value.banks.fold(0.0, (prevVal, bank) => prevVal + bank.amount);
}

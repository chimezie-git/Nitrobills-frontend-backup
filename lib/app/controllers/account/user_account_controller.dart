import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/user_account.dart';
import 'package:nitrobills/app/data/models/virtual_accounts/customer_model.dart';
import 'package:nitrobills/app/data/services/account/user_account_service.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class UserAccountController extends GetxController {
  final Rxn<CustomerModel> customer = Rxn<CustomerModel>(null);
  late final Rx<UserAccount> account;
  final RxDouble balance = RxDouble(0);
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);
  final RxString authToken = RxString("");
  final RxBool loaded = RxBool(false);

  Future initialize() async {
    if (!loaded.value) {
      //load data and set account value
      status.value = LoaderEnum.loading;
      final result = await UserAccountService.getAccount();
      if (result.isRight) {
        await Get.find<AuthController>().saveName(
            result.right.lastName, result.right.firstName, result.right.email);
        account = Rx<UserAccount>(result.right);
        if (account.value.banks.first.accountStatus.isPending) {
          NbToast.fetchAccount();
        }
        NbUtils.startNotificationPoll();
        status.value = LoaderEnum.success;
        loaded.value = true;
        // start notification polling
      } else {
        status.value = LoaderEnum.failed;
        NbToast.error(result.left.message);
      }
      update();
    }
  }

  Future reload({bool showToast = true}) async {
    final result = await UserAccountService.getAccount();
    if (result.isRight) {
      account.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      if (showToast) {
        NbToast.error(result.left.message);
      }
    }
    update();
  }

  double get totalAmount =>
      account.value.banks.fold(0.0, (prevVal, bank) => prevVal + bank.amount);
}

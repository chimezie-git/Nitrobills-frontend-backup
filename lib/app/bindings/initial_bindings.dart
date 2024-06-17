import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/controllers/account/manage_data_controller.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<NavbarController>(() => NavbarController());
    Get.lazyPut<UserAccountController>(() => UserAccountController(),
        fenix: true);
    Get.lazyPut<ManageDataController>(() => ManageDataController());
    Get.lazyPut<TransactionsController>(() => TransactionsController());
    Get.lazyPut<BeneficiariesController>(() => BeneficiariesController());
  }
}

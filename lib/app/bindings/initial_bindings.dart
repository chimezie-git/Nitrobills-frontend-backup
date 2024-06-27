import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/autopay_controller.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/controllers/account/manage_data_controller.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/controllers/bills/airtime_controller.dart';
import 'package:nitrobills/app/controllers/bills/betting_controller.dart';
import 'package:nitrobills/app/controllers/bills/cable_controller.dart';
import 'package:nitrobills/app/controllers/bills/data_controller.dart';
import 'package:nitrobills/app/controllers/bills/electricity_controller.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<NavbarController>(NavbarController(), permanent: true);
  }

  static void setupCustomBindings() {
    Get.put<UserAccountController>(UserAccountController(), permanent: true);
    Get.put<ManageDataController>(ManageDataController(), permanent: true);
    Get.put<TransactionsController>(TransactionsController(), permanent: true);
    Get.put<BeneficiariesController>(BeneficiariesController(),
        permanent: true);
    // bills controllers
    Get.put<AirtimeController>(AirtimeController(), permanent: true);
    Get.put<DataController>(DataController(), permanent: true);
    Get.put<BettingController>(BettingController(), permanent: true);
    Get.put<CableController>(CableController(), permanent: true);
    Get.put<ElectricityController>(ElectricityController(), permanent: true);
    Get.put<AutopayController>(AutopayController(), permanent: true);
  }
}

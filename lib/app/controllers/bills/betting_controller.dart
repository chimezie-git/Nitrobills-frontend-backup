import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/services/bills/bet_service.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_bet_data.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class BettingController extends GetxController {
  final RxList<BetServiceProvider> providers = RxList<BetServiceProvider>();
  final Rxn<GbBetData> userData = Rxn();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initializeProvider(BuildContext context) async {
    if (providers.isEmpty) {
      status.value = LoaderEnum.loading;
      final result = await BetService.getBettingProviders();
      if (result.isRight) {
        providers.value = result.right;
        status.value = LoaderEnum.success;
      } else {
        status.value = LoaderEnum.failed;
        // ignore: use_build_context_synchronously
        NbToast.error(context, result.left.message);
      }
      update();
    }
  }

  Future reloadProviders(BuildContext context,
      {bool showLoader = false}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await BetService.getBettingProviders();
    if (result.isRight) {
      providers.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
    }
    update();
  }

  Future loadUserData(
      BuildContext context, String provider, String customerId) async {
    status.value = LoaderEnum.loading;

    final result = await BetService.validateCustomer(provider, customerId);
    if (result.isRight) {
      userData.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
    }
    update();
  }

  Future<bool> buy(BuildContext context, BetBill bill) async {
    final result = await BetService.buy(bill);
    if (result.isRight) {
      Get.find<TransactionsController>().addTransaction(result.right);
      return true;
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
      return false;
    }
  }
}

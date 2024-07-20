// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/data/services/bills/electricity_service.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class ElectricityController extends GetxController {
  final RxBool providerLoaded = RxBool(false);
  final RxList<ElectricityServiceProvider> providers =
      RxList<ElectricityServiceProvider>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initializeProvider(
    BuildContext context,
  ) async {
    if (!providerLoaded.value) {
      status.value = LoaderEnum.loading;
      final result = await ElectricityService.getElectricityProviders();
      if (result.isRight) {
        providers.value = result.right;
        status.value = LoaderEnum.success;
        providerLoaded.value = true;
      } else {
        status.value = LoaderEnum.failed;
        NbToast.error(context, result.left.message);
      }
      update();
    }
  }

  Future reload(BuildContext context, {bool showLoader = false}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await ElectricityService.getElectricityProviders();
    if (result.isRight) {
      providers.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(context, result.left.message);
    }
  }

  Future<bool> buy(BuildContext context, ElectricityBill bill) async {
    final result = await ElectricityService.buy(bill);
    if (result.isRight) {
      Get.find<TransactionsController>().addTransaction(result.right);
      return true;
    } else {
      NbToast.error(context, result.left.message);
      return false;
    }
  }
}

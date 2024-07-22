// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/services/bills/data_service.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class DataController extends GetxController {
  final RxBool providerLoaded = RxBool(false);
  final RxList<MobileServiceProvider> providers =
      RxList<MobileServiceProvider>();
  final RxMap<String, List<GbDataPlans>> dataPlan =
      RxMap<String, List<GbDataPlans>>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initializeProvider(
    BuildContext context,
  ) async {
    if (providers.isEmpty) {
      status.value = LoaderEnum.loading;
      final result = await DataService.getMobileProiders();
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

  Future initializePlans(BuildContext context, String provider) async {
    if (!dataPlan.containsKey(provider)) {
      status.value = LoaderEnum.loading;
      final result = await DataService.getDataPlans(provider);
      if (result.isRight) {
        dataPlan[provider] = result.right;
        status.value = LoaderEnum.success;
      } else {
        status.value = LoaderEnum.failed;
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
    final result = await DataService.getMobileProiders();
    if (result.isRight) {
      providers.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(context, result.left.message);
    }
    update();
  }

  Future reloadPlans(BuildContext context, String provider,
      {bool showLoader = false}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await DataService.getDataPlans(provider);
    if (result.isRight) {
      dataPlan[provider] = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(context, result.left.message);
    }
    update();
  }

  List<GbDataPlans> getDataPlans(String provider) {
    if (dataPlan.containsKey(provider)) {
      return dataPlan[provider]!;
    } else {
      return [];
    }
  }

  Future<bool> buy(BuildContext context, DataBill bill) async {
    final result = await DataService.buy(bill);
    if (result.isRight) {
      Get.find<TransactionsController>().addTransaction(result.right);
      return true;
    } else {
      NbToast.error(context, result.left.message);
      return false;
    }
  }
}

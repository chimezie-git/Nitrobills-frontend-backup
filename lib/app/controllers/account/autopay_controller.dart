import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/services/autopay/autopay_service.dart';
import 'package:nitrobills/app/ui/pages/autopayments/models/autopay.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class AutopayController extends GetxController {
  final RxList<Autopay> autopay = RxList<Autopay>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);
  final RxBool loaded = RxBool(false);

  Future initialize(
    BuildContext context,
  ) async {
    if (!loaded.value) {
      status.value = LoaderEnum.loading;
      final result = await AutopayService.getAutopay();
      if (result.isRight) {
        autopay.value = result.right;
        status.value = LoaderEnum.success;
        loaded.value = true;
      } else {
        status.value = LoaderEnum.failed;
        // ignore: use_build_context_synchronously
        NbToast.error(context, result.left.message);
      }
      update();
    }
  }

  Future reload(BuildContext context,
      {bool showLoader = false, bool showToast = true}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await AutopayService.getAutopay();
    if (result.isRight) {
      autopay.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      if (showToast) {
        // ignore: use_build_context_synchronously
        NbToast.error(context, result.left.message);
      }
    }
    update();
  }

  Future<Autopay?> create(BuildContext context, Autopay autopay) async {
    final result = await AutopayService.createAutopay(autopay);
    if (result.isRight) {
      this.autopay.add(result.right);
      update();
      return result.right;
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
      return null;
    }
  }

  // double get totalBill{
  //   return autopay.fold(0, (e, auto)=>e+auto.p)
  // }
}

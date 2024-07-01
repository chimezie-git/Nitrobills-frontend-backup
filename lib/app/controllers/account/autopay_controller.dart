import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/services/autopay/autopay_service.dart';
import 'package:nitrobills/app/ui/pages/autopayments/models/autopay.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class AutopayController extends GetxController {
  final RxList<Autopay> autopay = RxList<Autopay>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);
  final RxBool loaded = RxBool(false);

  Future initialize() async {
    if (!loaded.value) {
      status.value = LoaderEnum.loading;
      final result = await AutopayService.getAutopay();
      if (result.isRight) {
        autopay.value = result.right;
        status.value = LoaderEnum.success;
        loaded.value = true;
      } else {
        status.value = LoaderEnum.failed;
        NbToast.error(result.left.message);
      }
      update();
    }
  }

  Future reload({bool showLoader = false, bool showToast = true}) async {
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
        NbToast.error(result.left.message);
      }
    }
    update();
  }

  void addAutopay(Autopay autopay) {
    this.autopay.add(autopay);
    update();
  }
}

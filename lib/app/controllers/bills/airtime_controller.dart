import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/services/bills/airtime_service.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class AirtimeController extends GetxController {
  final RxBool providerLoaded = RxBool(false);
  final RxList<MobileServiceProvider> providers =
      RxList<MobileServiceProvider>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initializeProvider() async {
    if (!providerLoaded.value) {
      status.value = LoaderEnum.loading;
      final result = await AirtimeService.getMobileProiders();
      if (result.isRight) {
        providers.value = result.right;
        status.value = LoaderEnum.success;
        providerLoaded.value = true;
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
    final result = await AirtimeService.getMobileProiders();
    if (result.isRight) {
      providers.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(result.left.message);
    }
  }

  Future<bool> buy(AirtimeBill bill) async {
    final result = await AirtimeService.buy(bill);
    if (result.isRight) {
      Get.find<TransactionsController>().addTransaction(result.right);
      return true;
    } else {
      NbToast.error(result.left.message);
      return false;
    }
  }
}

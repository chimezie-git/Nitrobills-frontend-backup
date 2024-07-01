import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/data/services/bills/cable_service.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_cable_plans.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class CableController extends GetxController {
  final RxBool providerLoaded = RxBool(false);
  final RxList<TvServiceProvider> providers = RxList<TvServiceProvider>();
  final RxMap<String, List<GbCablePlans>> cablePlans =
      RxMap<String, List<GbCablePlans>>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initializeProvider() async {
    if (providers.isEmpty) {
      status.value = LoaderEnum.loading;
      final result = await CableService.getCableProiders();
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

  Future initializePlans(String provider) async {
    if (!cablePlans.containsKey(provider)) {
      status.value = LoaderEnum.loading;
      final result = await CableService.getCablePlans(provider);
      if (result.isRight) {
        cablePlans[provider] = result.right;
        status.value = LoaderEnum.success;
      } else {
        status.value = LoaderEnum.failed;
        NbToast.error(result.left.message);
      }
      update();
    }
  }

  Future reloadProviders({bool showLoader = false}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await CableService.getCableProiders();
    if (result.isRight) {
      providers.value = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(result.left.message);
    }
    update();
  }

  Future reloadPlans(String provider, {bool showLoader = false}) async {
    if (showLoader) {
      status.value = LoaderEnum.loading;
    }
    final result = await CableService.getCablePlans(provider);
    if (result.isRight) {
      cablePlans[provider] = result.right;
      status.value = LoaderEnum.success;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(result.left.message);
    }
    update();
  }

  List<GbCablePlans> getCablePlans(String provider) {
    if (cablePlans.containsKey(provider)) {
      return cablePlans[provider]!;
    } else {
      return [];
    }
  }

  Future<bool> buy(CableBill bill) async {
    final result = await CableService.buy(bill);
    if (result.isRight) {
      Get.find<TransactionsController>().addTransaction(result.right);
      return true;
    } else {
      NbToast.error(result.left.message);
      return false;
    }
  }
}

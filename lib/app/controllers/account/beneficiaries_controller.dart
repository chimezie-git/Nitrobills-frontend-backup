import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/data/services/beneficiary/beneficiary_service.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class BeneficiariesController extends GetxController {
  final RxBool loaded = RxBool(false);
  final RxList<Beneficiary> beneficiaries = RxList<Beneficiary>();
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initialize() async {
    if (!loaded.value) {
      status.value = LoaderEnum.loading;
      final result = await BeneficiaryService.getBeneficiary();
      if (result.isRight) {
        beneficiaries.value = result.right;
        status.value = LoaderEnum.success;
        loaded.value = true;
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
    final result = await BeneficiaryService.getBeneficiary();
    if (result.isRight) {
      beneficiaries.value = result.right;
      status.value = LoaderEnum.success;
      loaded.value = true;
    } else {
      status.value = LoaderEnum.failed;
      NbToast.error(result.left.message);
    }
    update();
  }

  Future<int?> create({
    required String name,
    required String number,
    required ServiceTypesEnum serviceType,
    required AbstractServiceProvider provider,
  }) async {
    final result = await BeneficiaryService.createBeneficiary(
        name, serviceType, provider, number);
    if (result.isRight) {
      beneficiaries.add(result.right);
      NbToast.success("Beneficiary Saved");
      update();
      return result.right.id;
    } else {
      NbToast.error(result.left.message);
      return null;
    }
  }

  Future<bool> delete(Beneficiary beneficiary) async {
    final result = await BeneficiaryService.deleteBeneficiary(beneficiary.id);
    if (result.isRight) {
      beneficiaries.value =
          beneficiaries.where((b) => b.id != beneficiary.id).toList();
      NbToast.success("Beneficiary deleted");
      update();
      return true;
    } else {
      NbToast.error(result.left.message);
      return false;
    }
  }
}

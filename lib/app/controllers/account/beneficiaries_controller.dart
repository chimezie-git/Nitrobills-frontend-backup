import 'package:flutter/material.dart';
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
  // sorting
  final RxList<Beneficiary> filtered = RxList<Beneficiary>();
  final RxBool sortAtoZ = RxBool(true);
  final RxBool sortLastPay = RxBool(false);
  final Rx<ServiceTypesEnum> serviceTypeSort =
      Rx<ServiceTypesEnum>(ServiceTypesEnum.airtime);

  Future initialize(BuildContext context) async {
    if (!loaded.value) {
      status.value = LoaderEnum.loading;
      final result = await BeneficiaryService.getBeneficiary();
      if (result.isRight) {
        beneficiaries.value = result.right;
        filtered.value = result.right;
        status.value = LoaderEnum.success;
        loaded.value = true;
        update();
        sort();
      } else {
        status.value = LoaderEnum.failed;
        // ignore: use_build_context_synchronously
        NbToast.error(context, result.left.message);
        update();
      }
    }
  }

  Future reload(BuildContext context, {bool showLoader = false}) async {
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
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
    }
    update();
  }

  Future<int?> create(
    BuildContext context, {
    required String name,
    required String number,
    required ServiceTypesEnum serviceType,
    required AbstractServiceProvider provider,
    required int colorId,
    required int avatarId,
  }) async {
    final result = await BeneficiaryService.createBeneficiary(
        name, serviceType, provider, number, colorId, avatarId);
    if (result.isRight) {
      beneficiaries.add(result.right);
      // ignore: use_build_context_synchronously
      NbToast.success(context, "Beneficiary Saved");
      update();
      return result.right.id;
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
      return null;
    }
  }

  Future<bool> delete(BuildContext context, Beneficiary beneficiary) async {
    final result = await BeneficiaryService.deleteBeneficiary(beneficiary.id);
    if (result.isRight) {
      beneficiaries.value =
          beneficiaries.where((b) => b.id != beneficiary.id).toList();

      // ignore: use_build_context_synchronously
      NbToast.success(context, "Beneficiary deleted");

      update();
      return true;
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
      return false;
    }
  }

  void sort({
    ServiceTypesEnum? serviceType,
    bool? aToZ,
    bool? lastPay,
  }) async {
    serviceTypeSort.value = serviceType ?? serviceTypeSort.value;
    sortAtoZ.value = aToZ ?? sortAtoZ.value;
    sortLastPay.value = lastPay ?? sortLastPay.value;
    List<Beneficiary> filter = beneficiaries
        .where((ben) => ben.serviceType == serviceTypeSort.value)
        .toList();
    // sort items
    filter.sort((a, b) {
      if (sortAtoZ.value) {
        return a.name.compareTo(b.name);
      } else {
        return b.name.compareTo(a.name);
      }
    });
    if (sortLastPay.value) {
      filter.sort(
        (a, b) {
          if (a.lastPayment == null) {
            return 1;
          } else if (b.lastPayment == null) {
            return 0;
          } else {
            return a.lastPayment!.date.compareTo(b.lastPayment!.date);
          }
        },
      );
    }
    filtered.value = filter;
    update();
  }

  void serch(String query) {
    filtered.value = filtered.where((ben) {
      if (ben.name.toLowerCase().contains(query.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    }).toList();
    update();
  }
}

import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/data/models/user_mobile_data.dart';

class ManageDataController extends GetxController {
  final Rxn<UserMobileData> account = Rxn<UserMobileData>(null);
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);

  Future initialize([bool force = false]) async {
    if (force || !status.value.isSuccess) {
      //load data
      await Future.delayed(const Duration(seconds: 5));
    }
    status.value = LoaderEnum.success;
  }
}

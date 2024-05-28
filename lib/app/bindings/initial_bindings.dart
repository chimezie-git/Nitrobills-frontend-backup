import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
  }
}

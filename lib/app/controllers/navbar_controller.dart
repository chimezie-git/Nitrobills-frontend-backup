import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxInt tabIndex = 0.obs;
  RxBool showTab = false.obs;

  void changeIndex(int index) {
    showTab.value = true;
    tabIndex.value = index;
  }

  void toggleShowTab(bool show) {
    showTab.value = show;
  }
}

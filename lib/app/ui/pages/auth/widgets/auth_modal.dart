import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/utils/nb_contants.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AuthModal {
  static Future show(Widget page) async {
    showModalBottomSheet(
      context: NbUtils.nav.currentContext!,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(Get.context!).viewPadding.top),
        child: page,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      // enterBottomSheetDuration: NbContants.navDuration,
      // exitBottomSheetDuration: NbContants.navDuration,
      // ignoreSafeArea: true,
    );
  }

  // static Future show(Widget page) async {
  //   Get.bottomSheet(
  //     Padding(
  //       padding:
  //           EdgeInsets.only(top: MediaQuery.of(Get.context!).viewPadding.top),
  //       child: page,
  //     ),
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     enterBottomSheetDuration: NbContants.navDuration,
  //     exitBottomSheetDuration: NbContants.navDuration,
  //     ignoreSafeArea: true,
  //   );
  // }
}

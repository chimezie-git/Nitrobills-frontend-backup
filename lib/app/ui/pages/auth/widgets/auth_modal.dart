import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AuthModal {
  static Future<T?> show<T>(Widget page) async {
    return await showModalBottomSheet<T>(
      context: NbUtils.nav.currentContext!,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(Get.context!).viewPadding.top,
        ),
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

  static Future<T?> showWithoutPop<T>(Widget page) async {
    return await showModalBottomSheet<T>(
      context: NbUtils.nav.currentContext!,
      builder: (context) => PopScope(
        canPop: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(Get.context!).viewPadding.top,
          ),
          child: page,
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      // enterBottomSheetDuration: NbContants.navDuration,
      // exitBottomSheetDuration: NbContants.navDuration,
      // ignoreSafeArea: true,
    );
  }
}

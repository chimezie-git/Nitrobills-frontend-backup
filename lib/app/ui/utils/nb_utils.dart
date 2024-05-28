import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';

class NbUtils {
  static GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  static get removeNav {
    Get.find<NavbarController>().toggleShowTab(false);
  }

  static get showNav {
    Get.find<NavbarController>().toggleShowTab(true);
  }

  static setNavIndex(int index) {
    Get.find<NavbarController>().changeIndex(index);
  }

  static (DateTime, DateTime) get thisWeek {
    final now = DateTime.now();
    DateTime startDay = now.subtract(Duration(days: now.weekday));
    DateTime endDay = now.add(const Duration(days: 7));
    return (startDay, endDay);
  }

  static (DateTime, DateTime) get lastWeek {
    final now = DateTime.now();
    DateTime startDay = now.subtract(Duration(days: now.weekday + 7));
    DateTime endDay = now.add(const Duration(days: 7));
    return (startDay, endDay);
  }

  static Color listColor(int index) {
    final allColor = [0xFF897AE5, 0xFF2A6F7E, 0xFFD0119B];
    return Color(allColor[(index % allColor.length)]);
  }
}

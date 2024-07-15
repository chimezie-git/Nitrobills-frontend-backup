import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';
import 'package:nitrobills/app/data/models/app_notification.dart';
import 'package:nitrobills/app/data/services/notification/notification_service.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class NbUtils {
  static String baseUrl = "https://nitrobills-backend.onrender.com";
  // static String baseUrl = "http://127.0.0.1:8000";

  static GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  static late Stream<AppNotification> _notificationPollStream;

  static void startNotificationPoll() {
    _notificationPollStream = NotificationService.getNotificaitonStream();
    _notificationPollStream.listen((notify) {
      NotificationService.showNotification(
          notify.type.displayName, notify.message);
    });
  }

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

  static void removeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void copyClipBoard(String text, String toastMsg) async {
    ClipboardData data = ClipboardData(text: text);
    await Clipboard.setData(data);
    NbToast.copy(toastMsg);
  }

  static Future<void> openLink(String link, String failMessage) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      NbToast.show(failMessage);
    }
  }
}

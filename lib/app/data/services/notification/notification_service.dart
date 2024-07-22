import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/models/app_notification.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';
import 'package:nitrobills/main.dart';

class NotificationService {
  static int _notificationId = 0;
  static const String _channelId = "nitrobills_channel";
  static const String _channelName = "nitrobills_channel_name";

  static Map<String, dynamic> _header() => {
        "Content-Type": "application/json",
        "Authorization":
            "Token ${Get.find<UserAccountController>().authToken.value}",
      };

  static AsyncOrError<List<AppNotification>> _getNotifications() async {
    TypeOrError<dio.Response> response = await HttpService.get(
        "${NbUtils.baseUrl}/api/data/notifications/",
        header: _header());

    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        List<Map> data = List<Map>.from(responseData["data"]);
        List<AppNotification> notification = data
            .map<AppNotification>(
              (Map json) => AppNotification.fromJson(Map.from(json)),
            )
            .toList();
        return Right(notification);
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(AppError(msg));
      } else {
        return Left(
          AppError(HttpService.stringFromMap(responseData)),
        );
      }
    } else {
      return Left(response.left);
    }
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      _notificationId++,
      title,
      body,
      notificationDetails,
    );
  }

  static Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notify_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Stream<AppNotification> getNotificaitonStream() async* {
    while (true) {
      bool bankPending = Get.find<UserAccountController>()
          .account
          .value
          .banks
          .first
          .accountStatus
          .isPending;
      final notify = await NotificationService._getNotifications();
      if (notify.isRight) {
        if (notify.right.isNotEmpty) {
          for (AppNotification n in notify.right) {
            if (n.type.isAccountCreate) {
              await Get.find<UserAccountController>().reload();
              // } else if (n.type.isTransaction) {
              //   await Get.find<TransactionsController>().reload();
            } else if (n.type.isDeposit) {
              // await Get.find<TransactionsController>().reload();
              await Get.find<UserAccountController>().reload();
            }
            yield n;
            if (!bankPending) {
              await Future.delayed(const Duration(seconds: 30));
            }
          }
        }
      }
      if (bankPending) {
        await Future.delayed(const Duration(seconds: 30));
      } else {
        await Future.delayed(const Duration(seconds: 90));
      }
    }
  }
}

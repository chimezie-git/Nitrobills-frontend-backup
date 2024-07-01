import 'package:nitrobills/app/data/enums/notification_type_enum.dart';

class AppNotification {
  static const String _typeKey = "type";
  static const String _messageKey = "message";

  final NotificationTypeEnum type;
  final String message;

  AppNotification({required this.type, required this.message});

  factory AppNotification.fromJson(Map json) => AppNotification(
      type: NotificationTypeEnum.fromString(json[_typeKey]),
      message: json[_messageKey]);
}

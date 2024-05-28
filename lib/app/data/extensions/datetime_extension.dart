import 'package:nitrobills/app/data/enums/weekday_enum.dart';

extension DateTimeExtension on DateTime {
  WeekdayEnum get weekdayEnum => WeekdayEnum.all[weekday - 1];
}

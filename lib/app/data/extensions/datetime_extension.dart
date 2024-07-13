import 'package:nitrobills/app/data/enums/weekday_enum.dart';

extension DateTimeExtension on DateTime {
  WeekdayEnum get weekdayEnum => WeekdayEnum.all[weekday - 1];

  bool get isToday {
    DateTime now = DateTime.now();
    return (now.day == day) && (now.month == month) && (now.year == year);
  }

  bool sameDay(DateTime day) {
    return (day.day == this.day) && (day.month == month) && (day.year == year);
  }

  bool isBeforeToday() {
    DateTime now = DateTime.now();
    if (year < now.year) {
      return true;
    } else if (month < now.month) {
      return true;
    } else if (day < now.day) {
      return true;
    } else {
      return false;
    }
  }

  bool isInRange(DateTime startRange, DateTime endRange) {
    if (isAfter(startRange) && isBefore(endRange)) {
      return true;
    } else if (sameDay(startRange) || sameDay(endRange)) {
      return true;
    } else {
      return false;
    }
  }
}

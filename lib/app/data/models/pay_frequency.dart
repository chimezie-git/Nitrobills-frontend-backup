import 'package:nitrobills/app/data/enums/period_enum.dart';

abstract class PayFrequency {
  final PeriodEnum period;
  final int? days;

  PayFrequency({required this.period, this.days});

  static List<PayFrequency> all = [
    CustomFrequency(days: 1),
    DailyFrequency(),
    MonthFrequency(),
    YearFrequency()
  ];
}

class DailyFrequency extends PayFrequency {
  DailyFrequency() : super(period: PeriodEnum.day);
}

class MonthFrequency extends PayFrequency {
  MonthFrequency() : super(period: PeriodEnum.month);
}

class YearFrequency extends PayFrequency {
  YearFrequency() : super(period: PeriodEnum.year);
}

class CustomFrequency extends PayFrequency {
  CustomFrequency({required super.days}) : super(period: PeriodEnum.custom);
}

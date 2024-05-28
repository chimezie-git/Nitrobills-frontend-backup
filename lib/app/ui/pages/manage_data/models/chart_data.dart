import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/extensions/datetime_extension.dart';

class ChartData {
  final (DateTime, DateTime) dayRange;

  late List<String> xLabels;
  late List<double> yLabels;

  ChartData({required this.dayRange}) {
    _getData();
  }

  factory ChartData.sample() {
    final now = DateTime.now();
    final lastDay = now.subtract(const Duration(days: 7));
    return ChartData(
      dayRange: (
        lastDay,
        now,
      ),
    );
  }

  void _getData() {
    xLabels = [];
    yLabels = [];
    int daysLength =
        DateTimeRange(start: dayRange.$1, end: dayRange.$2).duration.inDays + 1;
    List<DateTime> daysList = List.generate(
      daysLength,
      (index) => dayRange.$2.subtract(
        Duration(days: index),
      ),
    );
    final rand = Random();
    for (int i = 0; i < daysLength; i++) {
      xLabels.add(daysList[i].weekdayEnum.name.capitalize ?? "");
      yLabels.add(rand.nextDouble() * 500.0);
    }
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/loader_enum.dart';
import 'package:nitrobills/app/ui/pages/manage_data/models/day_data.dart';

class ManageDataController extends GetxController {
  final Rx<LoaderEnum> status = Rx<LoaderEnum>(LoaderEnum.loading);
  Rx<DayData> selected = Rx(DayData(2, DateTime.now()));
  final RxBool loaded = RxBool(false);
  final RxDouble maxData = RxDouble(100);
  late Rx<(DateTime, DateTime)> dayRange;
  final RxList<DayData> data = RxList<DayData>();

  Future initialize() async {
    if (!loaded.value) {
      //load data
      await Future.delayed(const Duration(seconds: 1));
      loaded.value = true;
      final now = DateTime.now();
      final lastDay = now.subtract(const Duration(days: 7));
      dayRange = Rx((lastDay, now));
      getPlanRange(dayRange.value, doUpdate: false);

      update();
    }
    status.value = LoaderEnum.success;
  }

  Future getPlanRange((DateTime, DateTime) dayRange,
      {bool doUpdate = true}) async {
    List<DayData> range = [];
    this.dayRange.value = dayRange;
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
      range.add(DayData(rand.nextDouble() * 500.0, daysList[i]));
    }
    data.clear();
    print("----------------${range.length}------------");
    data.addAll(range);
    selected.value = data[2];
    _setMax();
    if (doUpdate) {
      update();
    }
  }

  void _setMax() {
    DayData max = data.reduce(
        (value, element) => value.data > element.data ? value : element);
    maxData.value = max.data;
  }
}

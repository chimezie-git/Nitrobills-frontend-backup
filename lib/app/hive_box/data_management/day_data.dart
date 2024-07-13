import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/data/extensions/datetime_extension.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';

part 'day_data.g.dart';

@HiveType(typeId: 2)
class DayData extends HiveObject {
  static String nameKey = "day_data_key";

  @HiveField(0)
  final DateTime day;
  @HiveField(1)
  final int data;

  DayData({required this.day, required this.data});

  String get weekDay => day.weekdayEnum.name.capitalize ?? "";

  static List<DayData> getAll() {
    List<DayData> data = NbHiveBox.dayDataBox.values.toList();
    data.sort((a, b) => a.day.compareTo(b.day));
    return data;
  }

  static Future<void> add(DateTime day, int bytes) async {
    await DayData(day: day, data: bytes).save();
  }
}

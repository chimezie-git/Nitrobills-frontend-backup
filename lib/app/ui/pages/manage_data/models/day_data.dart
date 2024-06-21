import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/extensions/datetime_extension.dart';

class DayData extends Equatable {
  final double data;
  final DateTime day;

  const DayData(this.data, this.day);

  @override
  List<Object?> get props => [day, data];

  String get weekDay => day.weekdayEnum.name.capitalize ?? "";
}

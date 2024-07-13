import 'package:hive_flutter/hive_flutter.dart';

part 'sim_card_data.g.dart';

@HiveType(typeId: 2)
class SimCardData extends HiveObject {
  @HiveField(0)
  final String provider;
  @HiveField(1)
  final String phoneNumber;
  @HiveField(2)
  int remainingData;
  @HiveField(3)
  int totalData;

  SimCardData({
    required this.provider,
    required this.phoneNumber,
    required this.remainingData,
    required this.totalData,
  });

  void removeUsedData(int data) {
    remainingData -= data;
  }
}

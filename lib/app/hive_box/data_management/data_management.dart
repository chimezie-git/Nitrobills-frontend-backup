import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/hive_box/data_management/sim_card_data.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';

part 'data_management.g.dart';

@HiveType(typeId: 1)
class DataManagement {
  static String nameKey = "data_management_key";

  @HiveField(0)
  final DateTime lastDay;
  @HiveField(1)
  final bool enabled;
  @HiveField(2)
  final List<SimCardData> simData;

  DataManagement({
    required this.lastDay,
    required this.enabled,
    required this.simData,
  });

  static Future updateData(
      {bool? enabled, DateTime? day, List<SimCardData>? simData}) async {
    final data = getData();
    final savedData = DataManagement(
      lastDay: day ?? data.lastDay,
      enabled: enabled ?? data.enabled,
      simData: simData ?? data.simData,
    );
    await _saveData(savedData);
  }

  static DataManagement getData() {
    return NbHiveBox.dataManagementBox.get("data") ??
        DataManagement(
          lastDay: DateTime.now(),
          enabled: false,
          simData: [],
        );
  }

  static Future<void> _saveData(DataManagement data) async {
    await NbHiveBox.dataManagementBox.put("data", data);
  }
}

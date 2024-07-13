import 'package:get/get.dart';
import 'package:nitrobills/app/data/extensions/datetime_extension.dart';
import 'package:nitrobills/app/data/services/manage_data/manage_data_service.dart';
import 'package:nitrobills/app/hive_box/data_management/data_management.dart';
import 'package:nitrobills/app/hive_box/data_management/day_data.dart';

class ManageDataController extends GetxController {
  final Rx<DateTime> selected = Rx<DateTime>(DateTime.now());
  final RxBool loaded = RxBool(false);
  final RxInt maxData = RxInt(100);
  final RxList<DayData> data = RxList<DayData>();
  late final Rx<DataManagement> dataManager;
  late final Rx<(DateTime, DateTime)> dayRange;

  Future initialize() async {
    if (!loaded.value) {
      // first update dayData and data management
      await ManageDataService.updateData();
      dataManager = Rx(DataManagement.getData());
      dayRange = Rx(_getDefaultRange());

      if (dataManager.value.enabled) {
        updatePlansWithDate(_getDefaultRange(), doUpdate: false);
      }
      loaded.value = true;
      update();
    }
  }

  Future reload() async {
    await ManageDataService.updateData();
    dataManager = Rx(DataManagement.getData());
    dayRange = Rx(_getDefaultRange());

    if (dataManager.value.enabled) {
      updatePlansWithDate(_getDefaultRange(), doUpdate: false);
    }
    update();
  }

  Future updatePlansWithDate((DateTime, DateTime) dayRange,
      {bool doUpdate = true}) async {
    // get mobile data between day range
    List<DayData> range = [];
    this.dayRange.value = dayRange;
    for (DayData dData in DayData.getAll()) {
      if (dData.day.isInRange(dayRange.$1, dayRange.$2)) {
        range.add(dData);
      }
    }
    data.value = range;

    // set maximum value
    DayData max = data.reduce(
        (value, element) => value.data > element.data ? value : element);
    maxData.value = max.data;

    // update data
    if (doUpdate) {
      update();
    }
  }

  (DateTime, DateTime) _getDefaultRange() {
    final now = DateTime.now();
    final lastDay = now.subtract(const Duration(days: 6));
    return (lastDay, now);
  }
}

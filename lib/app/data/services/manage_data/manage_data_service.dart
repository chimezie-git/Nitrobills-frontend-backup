import 'package:nitrobills/app/data/extensions/datetime_extension.dart';
import 'package:nitrobills/app/hive_box/data_management/data_management.dart';
import 'package:nitrobills/app/hive_box/data_management/day_data.dart';
import 'package:nitrobills/app/hive_box/data_management/sim_card_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class ManageDataService {
  static const MethodChannel _channel =
      MethodChannel('com.nitrobills.Nitrobills/data_management');

  static Future<void> updateSimInfo(String provider, int data) async {
    List<SimCardData> simCardData = await _getSimInfo();
    for (SimCardData sCard in simCardData) {
      if (sCard.provider.toLowerCase().contains(provider.toLowerCase())) {
        sCard.remainingData = data;
        sCard.totalData = data;
      }
    }
    final now = DateTime.now();
    await DataManagement.updateData(
        enabled: true, day: now, simData: simCardData);
  }

  static Future<void> updateData() async {
    DataManagement dataManage = DataManagement.getData();
    if (dataManage.enabled) {
      // update data
      if (dataManage.lastDay.isBeforeToday()) {
        final now = DateTime.now();
        int days = now.difference(dataManage.lastDay).inDays;
        // data consumed in time period
        int dataConsumed = 0;
        for (int i = 0; i < days; i++) {
          DateTime nextDay = dataManage.lastDay.add(Duration(days: i + 1));
          int bytes = await _getDataForDay(nextDay);
          dataConsumed += bytes;
          await DayData.add(nextDay, bytes);
        }
        List<SimCardData> simData = dataManage.simData;
        for (SimCardData sData in simData) {
          if (sData.totalData > 0) {
            if (sData.totalData >= dataConsumed) {
              sData.removeUsedData(dataConsumed);
              break;
            } else {
              sData.removeUsedData(sData.remainingData);
            }
          }
        }
        DataManagement.updateData(
          day: dataManage.lastDay.add(Duration(days: days)),
          simData: simData,
        );
      }
    }
  }

  static Future<int> _getDataForDay(DateTime day) async {
    DateTime startTime = DateTime(day.year, day.month, day.day);
    DateTime endTime = DateTime(day.year, day.month, day.day, 23, 59, 59);
    return await _getDataUsage(
      startTime.millisecondsSinceEpoch,
      endTime.millisecondsSinceEpoch,
    );
  }

  static Future<int> _getDataUsage(int startTime, int endTime) async {
    final int dataUsage = await _channel.invokeMethod('getDataUsage', {
      'startTime': startTime,
      'endTime': endTime,
    });
    return dataUsage;
  }

  static Future<List<SimCardData>> _getSimInfo() async {
    bool hasPermission = await checkSimInfoPermissions();
    List<SimCardData> simCardData = [];
    if (hasPermission) {
      final Map simInfo = await _channel.invokeMethod('getSimInfo');
      if (simInfo.length > 1) {
        int simLength = (simInfo.length / 2).round();
        for (int i = 0; i < simLength; i++) {
          int simIdx = i + 1;
          if (simInfo.containsKey("sim${simIdx}Carrier")) {
            simCardData.add(SimCardData(
                provider: simInfo["sim${simIdx}Carrier"],
                phoneNumber: simInfo["sim${simIdx}Number"],
                remainingData: 0,
                totalData: 0));
          }
        }
      }
    }
    return simCardData;
  }

  static Future<bool> checkSimInfoPermissions() async {
    if (await _requestPermission(Permission.phone) &&
        await _requestPermission(Permission.sms)) {
      // Permissions are granted, you can access phone state and phone numbers
      return true;
    } else {
      // Permissions are denied, handle appropriately
      return false;
    }
  }

  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    }
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }

  // Text('SIM 1 Number: ${_simInfo['sim1Number']}'),
  // Text('SIM 1 Carrier: ${_simInfo['sim1Carrier']}'),
  // Text('SIM 2 Number: ${_simInfo['sim2Number']}'),
  // Text('SIM 2 Carrier: ${_simInfo['sim2Carrier']}'),
  // Text('Current Data SIM: ${_simInfo['currentDataSim']}'),

  // Future<void> _getDataUsage() async {
  //   final int startTime = DateTime(2023, 1, 1).millisecondsSinceEpoch;
  //   final int endTime = DateTime(2023, 1, 31).millisecondsSinceEpoch;
  //   // get datausage in bytes
  //   final int dataUsage = await DataUsage.getDataUsage(startTime, endTime);
  // }
}

import 'package:hive_flutter/adapters.dart';
import 'package:nitrobills/app/hive_box/auth_data/auth_data.dart';
import 'package:nitrobills/app/hive_box/data_management/data_management.dart';
import 'package:nitrobills/app/hive_box/data_management/day_data.dart';
import 'package:nitrobills/app/hive_box/recent_payments/recent_payment.dart';

class NbHiveBox {
  static Box<AuthData> get authDataBox => Hive.box<AuthData>(AuthData.nameKey);
  static Box<DataManagement> get dataManagementBox =>
      Hive.box<DataManagement>(DataManagement.nameKey);
  static Box<DayData> get dayDataBox => Hive.box<DayData>(DayData.nameKey);
  static Box<RecentPayment> get recentPayBox =>
      Hive.box<RecentPayment>(RecentPayment.nameKey);

  static Future<void> registerAdapters() async {
    Hive.registerAdapter(AuthDataAdapter());
    Hive.registerAdapter(DataManagementAdapter());
    Hive.registerAdapter(DayDataAdapter());
    Hive.registerAdapter(RecentPaymentAdapter());
    await Hive.openBox<AuthData>(AuthData.nameKey);
    await Hive.openBox<DataManagement>(DataManagement.nameKey);
    await Hive.openBox<DayData>(DayData.nameKey);
    await Hive.openBox<RecentPayment>(RecentPayment.nameKey);
  }
}

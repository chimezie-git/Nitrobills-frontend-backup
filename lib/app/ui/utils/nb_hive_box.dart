import 'package:hive_flutter/adapters.dart';
import 'package:nitrobills/app/hive_box/auth_data/auth_data.dart';

class NbHiveBox {
  static Box<AuthData> get authDataBox => Hive.box<AuthData>(AuthData.nameKey);
}

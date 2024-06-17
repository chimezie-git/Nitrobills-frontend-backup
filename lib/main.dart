import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/hive_box/auth_data/auth_data.dart';
import 'package:nitrobills/nitrobills.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // init hive boxes
  await Hive.initFlutter();
  Hive.registerAdapter(AuthDataAdapter());
  await Hive.openBox<AuthData>(AuthData.nameKey);

  // end init hive box

  runApp(const NitroBills());
}

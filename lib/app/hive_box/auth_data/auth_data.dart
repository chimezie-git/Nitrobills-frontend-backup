import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';

part 'auth_data.g.dart';

@HiveType(typeId: 0)
class AuthData extends HiveObject {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final DateTime lastLogin;

  static const String nameKey = "auth_data_key";

  AuthData({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.lastLogin,
  });

  static Future updateData({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    DateTime? lastLogin,
  }) async {
    final data = getData() ??
        AuthData(
            email: "",
            password: "",
            firstName: "",
            lastName: "",
            lastLogin: DateTime.now());
    final savedData = AuthData(
      email: email ?? data.email,
      password: password ?? data.password,
      firstName: firstName ?? data.firstName,
      lastName: lastName ?? data.lastName,
      lastLogin: lastLogin ?? data.lastLogin,
    );
    await _saveData(savedData);
  }

  static AuthData? getData() {
    return NbHiveBox.authDataBox.get("data");
  }

  static Future<void> _saveData(AuthData data) async {
    await NbHiveBox.authDataBox.put("data", data);
  }

  // static Future<void> saveData(String lastName, String firstName, String email,
  //     String password, DateTime lastLogin) async {
  //   final authData = AuthData(
  //       email: email,
  //       password: password,
  //       firstName: firstName,
  //       lastName: lastName,
  //       lastLogin: lastLogin);
  //   await _saveData(authData);
  // }
}

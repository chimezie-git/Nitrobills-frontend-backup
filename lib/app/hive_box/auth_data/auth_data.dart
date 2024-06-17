import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';

part 'auth_data.g.dart';

@HiveType(typeId: 0)
class AuthData extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String firstName;
  @HiveField(4)
  final String lastName;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(6)
  final DateTime lastLogin;

  static const String nameKey = "auth_data_key";

  AuthData({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.lastLogin,
  });

  static Future updateData({
    String? username,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? lastLogin,
  }) async {
    final data = getData();
    if (data != null) {
      final savedData = AuthData(
        username: username ?? data.username,
        email: email ?? data.email,
        password: password ?? data.password,
        firstName: firstName ?? data.firstName,
        lastName: lastName ?? data.lastName,
        phoneNumber: phoneNumber ?? data.phoneNumber,
        lastLogin: lastLogin ?? data.lastLogin,
      );
      await _saveData(savedData);
    }
  }

  static AuthData? getData() {
    return NbHiveBox.authDataBox.get("data");
  }

  static Future<void> _saveData(AuthData data) async {
    await NbHiveBox.authDataBox.put("data", data);
  }

  static Future<void> saveData(
      String username,
      String lastName,
      String firstName,
      String email,
      String password,
      String phoneNumber,
      DateTime lastLogin) async {
    final authData = AuthData(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        lastLogin: lastLogin);
    await _saveData(authData);
  }
}

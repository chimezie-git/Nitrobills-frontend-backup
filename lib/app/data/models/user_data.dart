import 'package:nitrobills/app/data/services/custom_alphanumeric.dart';

class UserData {
  static const String firstNameKey = "first_name";
  static const String lastNameKey = "last_name";
  static const String usernameKey = "username";
  static const String emailKey = "email";
  static const String phoneNumberKey = "phone";
  static const String referralCodeKey = "referral_code";
  static const String referralCountKey = "referral_count";

  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNumber;
  final String referralCode;
  final int referralCount;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.referralCode,
    required this.referralCount,
  });

  factory UserData.newUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String phoneNumber,
  }) {
    String referralCode = CustomAlphaNumeric.uniqueTimeCode();
    return UserData(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        referralCode: referralCode,
        referralCount: 0);
  }
}

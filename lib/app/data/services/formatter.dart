import 'package:intl/intl.dart';

class NbFormatter {
  static final NumberFormat _numFormater = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );

  static String phone(String phone) {
    if (phone.length == 11) {
      return "+234${phone.substring(1)}";
    } else if (phone.length == 14) {
      return phone;
    } else if (phone.length > 14) {
      return phone;
    } else {
      throw ("Invalid phone number format");
    }
  }

  static String amount(double amount) => _numFormater.format(amount);
}

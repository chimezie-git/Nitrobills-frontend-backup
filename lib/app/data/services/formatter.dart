class NbFormatter {
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
}

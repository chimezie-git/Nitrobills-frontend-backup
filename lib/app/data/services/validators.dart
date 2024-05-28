class NbValidators {
  static final _emailRegex = RegExp(
      r"^[-!#$%&'*+/0-9=?A-Z^_a-z{|}~](\.?[-!#$%&'*+/0-9=?A-Z^_a-z{|}~])*@[a-zA-Z](-?[a-zA-Z0-9])*(\.[a-zA-Z](-?[a-zA-Z0-9])*)+$");

  static final _phoneRegex = RegExp(r"/^\+?[0-9]\d{1,20}$/");

  static bool isEmail(String val) => _emailRegex.hasMatch(val);
  static bool isPhone(String val) => _phoneRegex.hasMatch(val);
}

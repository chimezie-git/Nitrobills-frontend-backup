class NbValidators {
  static final _emailRegex = RegExp(
      r"^[-!#$%&'*+/0-9=?A-Z^_a-z{|}~](\.?[-!#$%&'*+/0-9=?A-Z^_a-z{|}~])*@[a-zA-Z](-?[a-zA-Z0-9])*(\.[a-zA-Z](-?[a-zA-Z0-9])*)+$");

  static final _phoneRegex = RegExp(r"^\+?[0-9]\d{1,20}$");

  static final _password = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  static final _username = RegExp(r"^[a-zA-Z0-9]{4,}$");
  static final _name = RegExp(r"^[a-zA-Z0-9 ,.]{4,}$");

  static bool isEmail(String val) => _emailRegex.hasMatch(val);
  static bool isPhone(String val) => _phoneRegex.hasMatch(val);
  static bool isPassword(String val) => _password.hasMatch(val);
  static bool isUsername(String val) => _username.hasMatch(val);
  static bool isName(String val) => _name.hasMatch(val);

  static bool isUsernameOrEmail(String val) {
    return _emailRegex.hasMatch(val) || _username.hasMatch(val);
  }
}

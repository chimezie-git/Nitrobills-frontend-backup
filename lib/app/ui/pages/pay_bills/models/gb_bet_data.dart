class GbBetData {
  static const String _providerKey = "provider";
  static const String _customerIdKey = "customerId";
  static const String _firstNameKey = "firstName";
  static const String _lastNameKey = "lastName";
  static const String _userNameKey = "userName";

  final String provider;
  final String customerId;
  final String firstName;
  final String lastName;
  final String userName;

  GbBetData(
      {required this.provider,
      required this.customerId,
      required this.firstName,
      required this.lastName,
      required this.userName});

  factory GbBetData.fromJson(Map json) => GbBetData(
        provider: json[_providerKey],
        customerId: json[_customerIdKey],
        firstName: json[_firstNameKey],
        lastName: json[_lastNameKey],
        userName: json[_userNameKey],
      );
}

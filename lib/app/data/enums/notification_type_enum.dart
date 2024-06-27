enum NotificationTypeEnum {
  deposit,
  accountCreate,
  transaction;

  bool get isDeposit => this == deposit;
  bool get isAccountCreate => this == accountCreate;
  bool get isTransaction => this == transaction;

  factory NotificationTypeEnum.fromString(String data) {
    switch (data.toLowerCase()) {
      case 'd':
        return deposit;
      case 'a':
        return accountCreate;
      case 't':
        return transaction;
      default:
        throw Exception("Nitrobills Error: Not a valid notification enum");
    }
  }

  String get displayName {
    switch (this) {
      case deposit:
        return "Account Credited";
      case accountCreate:
        return "Account Created";
      case transaction:
        return "Transaction Update";
    }
  }
}

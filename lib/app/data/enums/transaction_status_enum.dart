enum TransactionStatusEnum {
  failed,
  pending,
  success;

  bool get isPending => this == pending;
  bool get isFailed => this == failed;
  bool get isSuccess => this == success;

  static TransactionStatusEnum fromString(String status) {
    switch (status.toLowerCase()) {
      case 'p':
        return pending;
      case 'f':
        return failed;
      case 's':
        return success;
      default:
        throw Exception("Nitrobills Error: Invalid Transaction status");
    }
  }
}

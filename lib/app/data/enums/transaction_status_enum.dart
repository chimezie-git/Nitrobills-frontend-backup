enum TransactionStatusEnum {
  failed,
  pending,
  success;

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

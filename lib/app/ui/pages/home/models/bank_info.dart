class BankInfo {
  final String bankName;
  final String accountName;
  final String accountNumber;

  BankInfo({
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  });

  static BankInfo wema = BankInfo(
      bankName: "Wema Bank",
      accountName: "Alex Natan",
      accountNumber: "2343423423");
}

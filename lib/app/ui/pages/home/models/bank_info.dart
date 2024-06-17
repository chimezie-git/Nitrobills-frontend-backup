import 'package:equatable/equatable.dart';
import 'package:nitrobills/app/data/enums/transaction_status_enum.dart';

class BankInfo extends Equatable {
  static const String _idKey = "id";
  static const String _userKey = "user";
  static const String _amountKey = "amount";
  static const String _customerIdKey = "customer_id";
  static const String _customerCodeKey = "customer_code";
  static const String _accountStatusKey = "account_status";
  static const String _accountNumberKey = "account_number";
  static const String _accountNameKey = "account_name";
  static const String _bankNameKey = "bank_name";
  static const String _bankSlugKey = "bank_slug";
  static const String _currencyKey = "account_currency";

  final int id;
  final int user;
  final double amount;
  final int customerId;
  final String customerCode;
  final TransactionStatusEnum accountStatus;
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankSlug;
  final String currency;

  const BankInfo({
    required this.id,
    required this.user,
    required this.amount,
    required this.customerId,
    required this.customerCode,
    required this.accountStatus,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankSlug,
    required this.currency,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) {
    return BankInfo(
      id: json[_idKey],
      user: json[_userKey],
      amount: double.parse(json[_amountKey]),
      customerId: json[_customerIdKey],
      customerCode: json[_customerCodeKey],
      accountStatus: TransactionStatusEnum.fromString(json[_accountStatusKey]),
      accountNumber: json[_accountNumberKey],
      accountName: json[_accountNameKey],
      bankName: json[_bankNameKey],
      bankSlug: json[_bankSlugKey],
      currency: json[_currencyKey],
    );
  }

  factory BankInfo.empty() => const BankInfo(
      id: 12,
      user: 23,
      amount: 0,
      customerId: 0,
      customerCode: "customerCode",
      accountStatus: TransactionStatusEnum.pending,
      accountNumber: "accountNumber",
      accountName: "accountName",
      bankName: "bankName",
      bankSlug: "bankSlug",
      currency: "currency");

  @override
  List<Object?> get props => [
        id,
        user,
        bankName,
        accountName,
        accountNumber,
      ];
}

import 'package:nitrobills/app/data/enums/transaction_type_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class Transaction {
  static const String _idKey = "id";
  static const String _userKey = "user";
  static const String _referenceKey = "reference";
  static const String _dateKey = "date";
  static const String _statusKey = "status";
  static const String _isCreditKey = "is_credit";
  static const String _transactionTypeKey = "transaction_type";
  static const String _providerKey = "provider";
  static const String _recieverNumberKey = "reciever_number";
  static const String _amountKey = "amount";

  final int id;
  final int user;
  final String reference;
  final DateTime date;
  final String status;
  final bool isCredit;
  final TransactionTypeEnum transactionType;
  final String provider;
  final String recieverNumber;
  final double amount;

  Transaction({
    required this.id,
    required this.user,
    required this.reference,
    required this.date,
    required this.status,
    required this.isCredit,
    required this.transactionType,
    required this.provider,
    required this.recieverNumber,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json[_idKey],
      user: json[_userKey],
      reference: json[_referenceKey],
      date: DateTime.parse(json[_dateKey]),
      status: json[_statusKey],
      isCredit: json[_isCreditKey],
      transactionType:
          TransactionTypeEnum.fromServer(json[_transactionTypeKey]),
      provider: json[_providerKey],
      recieverNumber: json[_recieverNumberKey],
      amount: double.tryParse(json[_amountKey]) ?? 0.0,
    );
  }

  String get iconImage {
    if (transactionType.isDeposit) {
      return NbImage.starcomms;
    } else if (transactionType.isBulkSms) {
      return NbImage.starcomms;
    } else {
      return AbstractServiceProvider.fromServer(
              provider, transactionType.serviceType)
          .image;
    }
  }
}

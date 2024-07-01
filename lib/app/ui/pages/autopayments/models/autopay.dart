import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';

class Autopay {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _transactionTypeKey = "transaction_type";
  static const String _serviceProviderKey = "service_provider";
  static const String _lastPaymentKey = "last_payment";
  static const String _numberKey = "number";
  static const String _amountPlanKey = "amount_plan";
  static const String _periodKey = "period";
  static const String _customDaysKey = "custom_days";
  static const String _endDateKey = "end_date";

  final int id;
  final String name;
  final ServiceTypesEnum serviceType;
  final AbstractServiceProvider serviceProvider;
  final Transaction? lastPayment;
  final String number;
  final String amountPlan;
  final String period;
  final int customDays;
  final DateTime endDate;

  Autopay({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.serviceProvider,
    required this.lastPayment,
    required this.number,
    required this.amountPlan,
    required this.period,
    required this.customDays,
    required this.endDate,
  });

  factory Autopay.fromJson(Map json) {
    ServiceTypesEnum serviceType =
        ServiceTypesEnum.fromServer(json[_transactionTypeKey]);
    Transaction? tran = json[_lastPaymentKey] == null
        ? null
        : Transaction.fromJson(json[_lastPaymentKey]);
    return Autopay(
      id: json[_idKey],
      name: json[_nameKey],
      serviceType: serviceType,
      serviceProvider: AbstractServiceProvider.fromServer(
          json[_serviceProviderKey], serviceType),
      lastPayment: tran,
      number: json[_numberKey],
      amountPlan: json[_amountPlanKey],
      period: json[_periodKey],
      customDays: json[_customDaysKey],
      endDate: DateTime.parse(json[_endDateKey]),
    );
  }

  factory Autopay.fromBeneficiary(Beneficiary ben) {
    return Autopay(
      id: -1,
      name: ben.name,
      serviceType: ben.serviceType,
      serviceProvider: ben.serviceProvider,
      lastPayment: null,
      number: ben.code,
      amountPlan: "",
      period: '',
      customDays: 0,
      endDate: DateTime.now(),
    );
  }
}

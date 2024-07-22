import 'package:nitrobills/app/data/enums/period_enum.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/pay_frequency.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';

class Autopay {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _transactionTypeKey = "transaction_type";
  static const String _serviceProviderKey = "service_provider";
  static const String _lastPaymentKey = "last_payment";
  static const String _numberKey = "number";
  static const String _amountKey = "amount";
  static const String _uuidKey = "uuid";
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
  final String uuid;
  final double amount;
  final String amountPlan;
  final PeriodEnum period;
  final int customDays;
  final DateTime endDate;

  Autopay({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.serviceProvider,
    required this.lastPayment,
    required this.number,
    required this.amount,
    required this.uuid,
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
      amount: double.tryParse(json[_amountKey]) ?? 0,
      uuid: json[_uuidKey],
      serviceType: serviceType,
      serviceProvider: AbstractServiceProvider.fromServer(
          json[_serviceProviderKey], serviceType),
      lastPayment: tran,
      number: json[_numberKey],
      amountPlan: json[_amountPlanKey],
      period: PeriodEnum.fromServerString(json[_periodKey]),
      customDays: json[_customDaysKey],
      endDate: DateTime.parse(json[_endDateKey]),
    );
  }

  factory Autopay.fromBeneficiary(
    Beneficiary ben,
    PayFrequency payFreq,
    String amountPlan,
    DateTime endDate,
  ) {
    // String uid =
    //     "$amountPlan-${bill.serviceType.toServerString}-${payFreq.period.name}-${payFreq.days ?? 0}";
    return Autopay(
      id: -1,
      name: ben.name,
      serviceType: ben.serviceType,
      serviceProvider: ben.serviceProvider,
      lastPayment: null,
      amount: 0,
      uuid: "",
      number: ben.code,
      amountPlan: amountPlan,
      period: payFreq.period,
      customDays: payFreq.days ?? 0,
      endDate: endDate,
    );
  }

  factory Autopay.createNew(
    PayFrequency payFreq,
    DateTime endDate,
    Bill bill,
  ) {
    String amountPlan;
    double amount;
    if (bill is DataBill) {
      amountPlan = bill.plan.planId.toString();
      amount = bill.plan.amount;
    } else if (bill is CableBill) {
      amountPlan = bill.plan.planId.toString();
      amount = bill.plan.amount;
    } else {
      amountPlan = bill.amount.toString();
      amount = bill.amount;
    }
    String uuid =
        "$amountPlan-${bill.serviceType.toServerString}-${payFreq.period.name}-${payFreq.days ?? 0}";

    return Autopay(
      id: -1,
      name: bill.name,
      uuid: uuid,
      amount: amount,
      serviceType: bill.serviceType,
      serviceProvider: bill.provider,
      lastPayment: null,
      number: bill.codeNumber,
      amountPlan: amountPlan,
      period: payFreq.period,
      customDays: payFreq.days ?? 0,
      endDate: DateTime.now(),
    );
  }
}

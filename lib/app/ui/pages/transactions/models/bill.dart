import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_cable_plans.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';

class Bill {
  final double amount;
  final String name;
  final ServiceTypesEnum serviceType;
  final String codeNumber;
  final bool saveBeneficiary;
  final AbstractServiceProvider provider;

  Bill({
    required this.amount,
    required this.name,
    required this.serviceType,
    required this.codeNumber,
    required this.provider,
    required this.saveBeneficiary,
  });
}

class DataBill extends Bill {
  final GbDataPlans plan;
  DataBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required super.provider,
    required this.plan,
    required super.saveBeneficiary,
  }) : super(serviceType: ServiceTypesEnum.data);
}

class AirtimeBill extends Bill {
  AirtimeBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required super.provider,
    required super.saveBeneficiary,
  }) : super(serviceType: ServiceTypesEnum.airtime);
}

class CableBill extends Bill {
  final GbCablePlans plan;
  CableBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required super.provider,
    required this.plan,
    required super.saveBeneficiary,
  }) : super(serviceType: ServiceTypesEnum.cable);
}

class ElectricityBill extends Bill {
  ElectricityBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required super.provider,
    required super.saveBeneficiary,
  }) : super(serviceType: ServiceTypesEnum.electricity);
}

class BetBill extends Bill {
  BetBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required super.provider,
    required super.saveBeneficiary,
  }) : super(serviceType: ServiceTypesEnum.betting);
}

class BulkSMSBill extends Bill {
  final List<String> contacts;
  final String message;
  BulkSMSBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required this.contacts,
    required this.message,
  }) : super(
            serviceType: ServiceTypesEnum.bulkSms,
            provider: BulkSmsServiceProvider(),
            saveBeneficiary: false);
}

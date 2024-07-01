import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_cable_plans.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';

class Bill {
  final double amount;
  final String name;
  final ServiceTypesEnum serviceType;
  final String codeNumber;
  final int? beneficiaryId;

  Bill({
    required this.amount,
    required this.name,
    required this.serviceType,
    required this.codeNumber,
    this.beneficiaryId,
  });
}

class DataBill extends Bill {
  final MobileServiceProvider provider;
  final GbDataPlans plan;
  DataBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required this.provider,
    required this.plan,
    super.beneficiaryId,
  }) : super(serviceType: ServiceTypesEnum.data);
}

class AirtimeBill extends Bill {
  final MobileServiceProvider provider;
  AirtimeBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required this.provider,
    super.beneficiaryId,
  }) : super(serviceType: ServiceTypesEnum.data);
}

class CableBill extends Bill {
  final TvServiceProvider provider;
  final GbCablePlans plan;
  CableBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required this.provider,
    required this.plan,
    super.beneficiaryId,
  }) : super(serviceType: ServiceTypesEnum.cable);
}

class ElectricityBill extends Bill {
  final ElectricityServiceProvider provider;
  ElectricityBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required this.provider,
    super.beneficiaryId,
  }) : super(serviceType: ServiceTypesEnum.electricity);
}

class BetBill extends Bill {
  final BetServiceProvider provider;
  BetBill({
    required super.amount,
    required super.name,
    required super.codeNumber,
    required this.provider,
    super.beneficiaryId,
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
  }) : super(serviceType: ServiceTypesEnum.bulkSms);
}

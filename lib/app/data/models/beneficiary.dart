import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';

class Beneficiary {
  final String name;
  final ServiceTypesEnum serviceType;
  final AbstractServiceProvider serviceProvider;
  final String code;
  final DateTime? lastPayment;
  final double? lastPrice;

  Beneficiary({
    required this.name,
    required this.serviceType,
    required this.serviceProvider,
    required this.code,
    this.lastPayment,
    this.lastPrice,
  });

  static List<Beneficiary> all = [
    _nullPayment(
        "Josh Fringe", ServiceTypesEnum.airtime, MobileServiceProvider.glo),
    _nullPayment(
        "Josh Fringe", ServiceTypesEnum.data, MobileServiceProvider.glo),
    _nullPayment("Josh Fringe", ServiceTypesEnum.cable, TvServiceProvider.dstv),
    _nullPayment("Josh Fringe", ServiceTypesEnum.electricity,
        ElectricityServiceProvider.apleNg),
    _airtimeLastWeek("John Doe", MobileServiceProvider.mtn, 200),
    _airtimeLastWeek("Fredrick Doe", MobileServiceProvider.glo, 200),
    _airtimeLastWeek("Samanta Doe", MobileServiceProvider.airtel, 200),
    _airtimeLast2Week("John Doe", MobileServiceProvider.mtn, 200),
    _airtimeLast2Week("Fredrick Doe", MobileServiceProvider.glo, 200),
    _airtimeLast2Week("Samanta Doe", MobileServiceProvider.airtel, 200),
    _dataLastWeek("John Doe", MobileServiceProvider.mtn, 200),
    _dataLastWeek("Fredrick Doe", MobileServiceProvider.glo, 200),
    _dataLastWeek("Samanta Doe", MobileServiceProvider.airtel, 200),
    _dataLast2Week("John Doe", MobileServiceProvider.mtn, 200),
    _dataLast2Week("Fredrick Doe", MobileServiceProvider.glo, 200),
    _dataLast2Week("Samanta Doe", MobileServiceProvider.airtel, 200),
    _cableLastWeek("Ojo Market", TvServiceProvider.dstv, 300),
    _cableLastWeek("Okoro Destiny", TvServiceProvider.gotv, 300),
    _cableLast2Week("Ojo Market", TvServiceProvider.dstv, 300),
    _cableLast2Week("Okoro Destiny", TvServiceProvider.gotv, 300),
  ];
}

Beneficiary _nullPayment(
  String name,
  ServiceTypesEnum serviceType,
  AbstractServiceProvider provider,
) =>
    Beneficiary(
      name: name,
      serviceType: serviceType,
      serviceProvider: provider,
      code: "329043204",
    );

Beneficiary _cableLastWeek(
        String name, TvServiceProvider provider, double amount) =>
    Beneficiary(
      name: name,
      serviceType: ServiceTypesEnum.cable,
      serviceProvider: provider,
      lastPayment: _lastWeek,
      lastPrice: amount,
      code: "329043204",
    );
Beneficiary _cableLast2Week(
        String name, TvServiceProvider provider, double amount) =>
    Beneficiary(
      name: name,
      serviceType: ServiceTypesEnum.cable,
      serviceProvider: provider,
      lastPayment: _last2Week,
      lastPrice: amount,
      code: "29304923049",
    );
Beneficiary _airtimeLastWeek(
        String name, MobileServiceProvider provider, double amount) =>
    Beneficiary(
      name: name,
      serviceType: ServiceTypesEnum.airtime,
      serviceProvider: provider,
      lastPayment: _lastWeek,
      lastPrice: amount,
      code: "29304923049",
    );
Beneficiary _airtimeLast2Week(
        String name, MobileServiceProvider provider, double amount) =>
    Beneficiary(
      name: name,
      serviceType: ServiceTypesEnum.airtime,
      serviceProvider: provider,
      lastPayment: _last2Week,
      lastPrice: amount,
      code: "29304923049",
    );
Beneficiary _dataLastWeek(
        String name, MobileServiceProvider provider, double amount) =>
    Beneficiary(
      name: name,
      serviceType: ServiceTypesEnum.data,
      serviceProvider: provider,
      lastPayment: _lastWeek,
      lastPrice: amount,
      code: "29304923049",
    );
Beneficiary _dataLast2Week(
        String name, MobileServiceProvider provider, double amount) =>
    Beneficiary(
      name: name,
      serviceType: ServiceTypesEnum.data,
      serviceProvider: provider,
      lastPayment: _last2Week,
      lastPrice: amount,
      code: "29304923049",
    );

DateTime _lastWeek = DateTime(2024, 5, 15);
DateTime _last2Week = DateTime(2024, 5, 7);

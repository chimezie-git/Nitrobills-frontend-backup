import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

enum TransactionTypeEnum {
  airtime,
  data,
  cable,
  betting,
  electricity,
  bulkSms,
  deposit;

  String get displayName {
    switch (this) {
      case deposit:
        return "Deposit";
      case data:
        return "Buy Data";
      case airtime:
        return "Buy Airtime";
      case cable:
        return "Cable TV";
      case betting:
        return "Betting";
      case electricity:
        return "Electricity";
      case bulkSms:
        return "Bulk SMS";
    }
  }

  String get img {
    switch (this) {
      case deposit:
        return NbImage.fundAccount;
      case data:
        return NbImage.mtn;
      case airtime:
        return NbImage.buyAirtime;
      case cable:
        return NbImage.dstv;
      case betting:
        return NbImage.bet9ja;
      case electricity:
        return NbImage.eedc;
      case bulkSms:
        return NbImage.buyAirtime;
    }
  }

  ServiceTypesEnum get serviceType {
    switch (this) {
      case data:
        return ServiceTypesEnum.data;
      case airtime:
        return ServiceTypesEnum.airtime;
      case cable:
        return ServiceTypesEnum.cable;
      case betting:
        return ServiceTypesEnum.betting;
      case electricity:
        return ServiceTypesEnum.electricity;
      case bulkSms:
      case deposit:
        throw Exception("Nitrobills error: Not a valid type");
    }
  }

  factory TransactionTypeEnum.fromServer(String serviceType) {
    switch (serviceType) {
      case "at":
        return airtime;
      case "da":
        return data;
      case "ca":
        return cable;
      case "bt":
        return betting;
      case "el":
        return electricity;
      case "bs":
        return bulkSms;
      case "dt":
        return deposit;
      default:
        throw Exception("Error Invalid Mobile Service");
    }
  }

  String get toServerString {
    switch (this) {
      case airtime:
        return 'at';
      case data:
        return 'da';
      case cable:
        return 'ca';
      case electricity:
        return 'el';
      case betting:
        return 'bt';
      case bulkSms:
        return 'bs';
      case deposit:
        return 'dt';
    }
  }

  static List<TransactionTypeEnum> all = [
    airtime,
    data,
    cable,
    betting,
    electricity,
    deposit,
  ];

  bool get isDeposit => this == deposit;
  bool get isBulkSms => this == bulkSms;
  bool get isBetting => this == betting;
  bool get isCable => this == cable;
  bool get isData => this == data;
  bool get isAirtime => this == airtime;
  bool get isElectricity => this == electricity;
}

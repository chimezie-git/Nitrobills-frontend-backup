import 'package:nitrobills/app/ui/utils/nb_image.dart';

enum ServiceTypesEnum {
  airtime,
  data,
  cable,
  betting,
  electricity,
  bulkSms;

  bool get hasPlan {
    switch (this) {
      case data:
      case cable:
        return true;
      default:
        return false;
    }
  }

  String get name {
    switch (this) {
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

  String get shortName {
    switch (this) {
      case data:
        return "Data";
      case airtime:
        return "Airtime";
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

  int get toInt {
    switch (this) {
      case data:
        return 0;
      case airtime:
        return 1;
      case cable:
        return 2;
      case betting:
        return 3;
      case electricity:
        return 4;
      case bulkSms:
        return 5;
    }
  }

  factory ServiceTypesEnum.fromInt(int val) {
    switch (val) {
      case 0:
        return data;
      case 1:
        return airtime;
      case 2:
        return cable;
      case 3:
        return betting;
      case 4:
        return electricity;
      case 5:
        return bulkSms;
      default:
        throw Exception("Error Invalid Mobile Service");
    }
  }

  static List<ServiceTypesEnum> all = [
    airtime,
    data,
    cable,
    betting,
    electricity,
  ];
}

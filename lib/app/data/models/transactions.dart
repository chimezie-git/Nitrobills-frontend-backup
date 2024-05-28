import 'package:nitrobills/app/data/enums/service_types_enum.dart';

class Transaction {
  final ServiceTypesEnum serviceTypes;
  final double charge;
  final String refId;

  /// number for phone and id for cable
  final String code;
  final double price;
  final DateTime time;

  Transaction({
    required this.serviceTypes,
    required this.price,
    required this.charge,
    required this.time,
    required this.refId,
    required this.code,
  });

  static Transaction sampleMobile = Transaction(
    serviceTypes: ServiceTypesEnum.airtime,
    charge: 0,
    refId: "98239393",
    code: "90922029355",
    time: DateTime.now(),
    price: 2000,
  );

  static Transaction sampleData = Transaction(
    serviceTypes: ServiceTypesEnum.data,
    charge: 0,
    refId: "98239393",
    code: "90922029355",
    time: DateTime.now(),
    price: 2000,
  );

  static Transaction sampleCable = Transaction(
    serviceTypes: ServiceTypesEnum.cable,
    charge: 0,
    refId: "98239393",
    code: "92382323",
    time: DateTime.now(),
    price: 2000,
  );

  static Transaction sampleBetting = Transaction(
    serviceTypes: ServiceTypesEnum.betting,
    charge: 0,
    refId: "98239393",
    code: "92382323",
    time: DateTime.now(),
    price: 2000,
  );

  static Transaction sampleElectricity = Transaction(
    serviceTypes: ServiceTypesEnum.electricity,
    charge: 0,
    refId: "98239393",
    code: "92382323",
    time: DateTime.now(),
    price: 2000,
  );

  static Transaction sampleSMS = Transaction(
    serviceTypes: ServiceTypesEnum.bulkSms,
    charge: 0,
    refId: "98239393",
    code: "92382323",
    time: DateTime.now(),
    price: 2000,
  );
}

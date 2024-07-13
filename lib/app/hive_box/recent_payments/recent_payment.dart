import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';
import 'package:uuid/uuid.dart';

part 'recent_payment.g.dart';

@HiveType(typeId: 3)
class RecentPayment extends HiveObject {
  static const String nameKey = "recent_payment_hive_key";

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int serviceType;
  @HiveField(3)
  final String serviceProvider;
  @HiveField(4)
  final String number;

  RecentPayment({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.serviceProvider,
    required this.number,
  });

  ServiceTypesEnum get serviceTypesEnum =>
      ServiceTypesEnum.fromInt(serviceType);

  static Future add({
    required int serviceType,
    required String name,
    required String serviceProvider,
    required String number,
  }) async {
    String id = const Uuid().v4();
    NbHiveBox.recentPayBox.put(
      id,
      RecentPayment(
          id: id,
          name: name,
          serviceType: serviceType,
          serviceProvider: serviceProvider,
          number: number),
    );
  }
}

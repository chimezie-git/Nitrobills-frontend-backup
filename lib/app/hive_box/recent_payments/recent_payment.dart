import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
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

  AbstractServiceProvider get provider {
    return AbstractServiceProvider.fromServer(
        serviceProvider, serviceTypesEnum);
  }

  static Future add({
    required int serviceType,
    required String name,
    required String serviceProvider,
    required String number,
  }) async {
    String id = const Uuid().v4();
    final item = NbHiveBox.recentPayBox.values.where(
      (rP) =>
          (rP.number == number) &&
          (rP.serviceType == serviceType) &&
          (rP.serviceProvider == serviceProvider),
    );
    if (item.isEmpty) {
      await NbHiveBox.recentPayBox.put(
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
}

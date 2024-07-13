import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';

abstract class AbstractServiceProvider {
  final String id;
  final String name;
  final String image;

  AbstractServiceProvider(this.id, this.name, this.image);

  static AbstractServiceProvider fromServer(
      String serviceProvider, ServiceTypesEnum serviceType) {
    switch (serviceType) {
      case ServiceTypesEnum.airtime:
        return MobileServiceProvider.fromString(serviceProvider);
      case ServiceTypesEnum.data:
        return MobileServiceProvider.fromString(serviceProvider);
      case ServiceTypesEnum.cable:
        return TvServiceProvider.fromString(serviceProvider);
      case ServiceTypesEnum.electricity:
        return ElectricityServiceProvider.fromString(serviceProvider);
      case ServiceTypesEnum.betting:
        return BetServiceProvider.fromString(serviceProvider);
      case ServiceTypesEnum.bulkSms:
        throw Exception("Nitrobills error: provider not available in bulk sms");
    }
  }
}

class BulkSmsServiceProvider extends AbstractServiceProvider {
  BulkSmsServiceProvider() : super("", "", "");
}

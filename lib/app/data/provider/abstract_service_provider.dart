import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/betting_service_provider_modal.dart';

abstract class AbstractServiceProvider {
  final String id;
  final String name;
  final String image;

  AbstractServiceProvider(this.id, this.name, this.image);

  String typeName() {
    if (this is MobileServiceProvider) {
      return "mobile";
    } else if (this is TvServiceProvider) {
      return "cable";
    } else if (this is BettingServiceProviderModal) {
      return "bet";
    } else if (this is ElectricityServiceProvider) {
      return "electricity";
    }
    return "";
  }
}

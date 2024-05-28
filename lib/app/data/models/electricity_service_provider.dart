import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class ElectricityServiceProvider extends AbstractServiceProvider {
  ElectricityServiceProvider._(super.id, super.name, super.image);

  static ElectricityServiceProvider eedc =
      ElectricityServiceProvider._("eedc", "EEDC", NbImage.eedc);
  static ElectricityServiceProvider apleNg =
      ElectricityServiceProvider._("apleng", "APLE NG", NbImage.apleNg);
  static ElectricityServiceProvider bedc =
      ElectricityServiceProvider._("bedc", "BEDC", NbImage.bedc);

  static List<ElectricityServiceProvider> all = [eedc, apleNg, bedc];
}

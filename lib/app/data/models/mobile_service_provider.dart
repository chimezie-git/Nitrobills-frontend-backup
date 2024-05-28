import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class MobileServiceProvider extends AbstractServiceProvider {
  MobileServiceProvider._(super.id, super.name, super.image);

  static MobileServiceProvider mtn =
      MobileServiceProvider._("mtn", "MTN", NbImage.mtn);
  static MobileServiceProvider airtel =
      MobileServiceProvider._("airtel", "Airtel", NbImage.airtel);
  static MobileServiceProvider nineMobile =
      MobileServiceProvider._("9mobile", "9mobile", NbImage.nineMobile);
  static MobileServiceProvider glo =
      MobileServiceProvider._("glo", "Glo", NbImage.glo);

  static List<MobileServiceProvider> all = [
    mtn,
    airtel,
    nineMobile,
    glo,
  ];
}

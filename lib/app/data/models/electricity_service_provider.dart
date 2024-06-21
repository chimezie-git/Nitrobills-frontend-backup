import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

// {
//             "provider": "IKEDC",
//             "code": "ikeja-electric",
//             "providerLogoUrl": "assets/images/bills/Ikeja-Electric-Payment-PHCN.jpg",
//             "minAmount": "500"
//         }

class ElectricityServiceProvider extends AbstractServiceProvider {
  double minAmount = 0;
  ElectricityServiceProvider._(super.id, super.name, super.image);

  factory ElectricityServiceProvider.fromString(String data) {
    return eedc;
  }

  static ElectricityServiceProvider aedc = ElectricityServiceProvider._(
      "AEDC", "Abuja Electric", NbImage.abujaElect);
  static ElectricityServiceProvider kaedco = ElectricityServiceProvider._(
      "KAEDCO", "Kaduna Electric", NbImage.kadunaElect);
  static ElectricityServiceProvider ibedc = ElectricityServiceProvider._(
      "IBEDC", "Ibadan Electric", NbImage.ibadanElect);
  static ElectricityServiceProvider jed =
      ElectricityServiceProvider._("JED", "Jos Electric", NbImage.josElect);
  static ElectricityServiceProvider phed = ElectricityServiceProvider._(
      "PHED", "Portharcourt Electric", NbImage.phElect);
  static ElectricityServiceProvider kedco =
      ElectricityServiceProvider._("KEDCO", "Kano Electric", NbImage.kanoElect);
  static ElectricityServiceProvider ekedc =
      ElectricityServiceProvider._("EKEDC", "Eko Electric", NbImage.ekoElect);
  static ElectricityServiceProvider ikedc = ElectricityServiceProvider._(
      "IKEDC", "Ikeja Electric", NbImage.ikejaElect);
  static ElectricityServiceProvider eedc =
      ElectricityServiceProvider._("EEDC", "EEDC", NbImage.eedc);
  static ElectricityServiceProvider apleNg =
      ElectricityServiceProvider._("APLENG", "APLE NG", NbImage.apleNg);
  static ElectricityServiceProvider bedc =
      ElectricityServiceProvider._("BEDC", "BEDC", NbImage.bedc);

  static List<ElectricityServiceProvider> all = [
    aedc,
    kaedco,
    ibedc,
    jed,
    phed,
    kedco,
    ekedc,
    ikedc,
    eedc,
    apleNg,
    bedc,
  ];

  static Map<String, ElectricityServiceProvider> allDataMap = {
    aedc.id: aedc,
    kaedco.id: kaedco,
    ibedc.id: ibedc,
    jed.id: jed,
    phed.id: phed,
    kedco.id: kedco,
    ekedc.id: ekedc,
    ikedc.id: ikedc,
    eedc.id: eedc,
    apleNg.id: apleNg,
    bedc.id: bedc,
  };

  final String electMinError = "This is below the minimum amount for payment";
}

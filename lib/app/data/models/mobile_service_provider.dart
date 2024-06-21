import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class MobileServiceProvider extends AbstractServiceProvider {
  double minAmount = 0;
  MobileServiceProvider._(super.id, super.name, super.image);

  factory MobileServiceProvider.fromString(String data) {
    // change this later
    return mtn;
  }

  static MobileServiceProvider mtn =
      MobileServiceProvider._("MTN", "MTN", NbImage.mtn);
  static MobileServiceProvider airtel =
      MobileServiceProvider._("AIRTEL", "Airtel", NbImage.airtel);
  static MobileServiceProvider nineMobile =
      MobileServiceProvider._("9MOBILE", "9mobile", NbImage.nineMobile);
  static MobileServiceProvider glo =
      MobileServiceProvider._("GLO", "Glo", NbImage.glo);
  static MobileServiceProvider starcomms =
      MobileServiceProvider._("starcomms", "Starcomms", NbImage.starcomms);
  static MobileServiceProvider mtel =
      MobileServiceProvider._("mtel", "Mtel", NbImage.mtel);
  static MobileServiceProvider multilinks =
      MobileServiceProvider._("multilinks", "Multi Link", NbImage.multilinks);
  static MobileServiceProvider smile =
      MobileServiceProvider._("SMILE4G", "Smile", NbImage.smileTelecom);
  static MobileServiceProvider spectranet =
      MobileServiceProvider._("SPECTRANET", "Spectranet", NbImage.spectranet);

  static List<MobileServiceProvider> all = [
    mtn,
    airtel,
    nineMobile,
    glo,
    starcomms,
    mtel,
    multilinks,
    smile,
  ];

  static Map<String, MobileServiceProvider> allAirtimeMap = {
    mtn.id: mtn,
    airtel.id: airtel,
    nineMobile.id: nineMobile,
    glo.id: glo,
    starcomms.id: starcomms,
  };

  static Map<String, MobileServiceProvider> allDataMap = {
    mtn.id: mtn,
    airtel.id: airtel,
    nineMobile.id: nineMobile,
    glo.id: glo,
    smile.id: smile,
    spectranet.id: spectranet,
  };

  final String airtimeError = "This is below the minimum airtime amount";
  final String dataError = "Please Select a data plan";
}

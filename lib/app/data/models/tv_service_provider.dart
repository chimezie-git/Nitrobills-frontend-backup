import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class TvServiceProvider extends AbstractServiceProvider {
  TvServiceProvider._(super.id, super.name, super.image);

  factory TvServiceProvider.fromString(String data) {
    // change this later
    return dstv;
  }

  static TvServiceProvider dstv =
      TvServiceProvider._("DSTV", "DSTV", NbImage.dstv);
  static TvServiceProvider startimes =
      TvServiceProvider._("STARTIMES", "Startimes", NbImage.startimes);
  static TvServiceProvider gotv =
      TvServiceProvider._("GOTV", "GoTV NG", NbImage.gotv);
  static TvServiceProvider showmax =
      TvServiceProvider._("SHOWMAX", "Showmax", NbImage.showMax);

  static List<TvServiceProvider> all = [
    dstv,
    startimes,
    gotv,
    showmax,
  ];

  static Map<String, TvServiceProvider> allDataMap = {
    dstv.id: dstv,
    startimes.id: startimes,
    gotv.id: gotv,
    showmax.id: showmax,
  };
}

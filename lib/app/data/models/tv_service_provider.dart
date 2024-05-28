import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class TvServiceProvider extends AbstractServiceProvider {
  TvServiceProvider._(super.id, super.name, super.image);

  static TvServiceProvider dstv =
      TvServiceProvider._("dstv", "DSTV", NbImage.dstv);
  static TvServiceProvider startimes =
      TvServiceProvider._("startimes", "Startimes", NbImage.startimes);
  static TvServiceProvider gotv =
      TvServiceProvider._("gotv", "GoTV NG", NbImage.gotv);
  static TvServiceProvider showmax =
      TvServiceProvider._("showmax", "Showmax", NbImage.showMax);

  static List<TvServiceProvider> all = [
    dstv,
    startimes,
    gotv,
    showmax,
  ];
}

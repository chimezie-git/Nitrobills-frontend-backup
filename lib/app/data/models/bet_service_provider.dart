import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class BetServiceProvider extends AbstractServiceProvider {
  BetServiceProvider._(super.id, super.name, super.image);

  static BetServiceProvider sportybet =
      BetServiceProvider._("sportybet", "Sporty Bet", NbImage.sportyBet);
  static BetServiceProvider merrybet =
      BetServiceProvider._("merrybet", "Merrybet", NbImage.merryBet);
  static BetServiceProvider betway =
      BetServiceProvider._("betway", "Betway", NbImage.betWay);
  static BetServiceProvider betking =
      BetServiceProvider._("betking", "Betking", NbImage.betKing);
  static BetServiceProvider betnaija =
      BetServiceProvider._("betnaija", "Bet9ja", NbImage.bet9ja);
  static BetServiceProvider oneXBet =
      BetServiceProvider._("oneXBet", "1XBet", NbImage.oneXBet);
  static BetServiceProvider nairabet =
      BetServiceProvider._("nairabet", "Nairabet", NbImage.nairaBet);

  static List<BetServiceProvider> all = [
    sportybet,
    merrybet,
    betway,
    betking,
    betnaija,
    oneXBet,
    nairabet,
  ];
}

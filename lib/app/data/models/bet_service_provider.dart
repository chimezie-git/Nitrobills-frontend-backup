import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class BetServiceProvider extends AbstractServiceProvider {
  double minAmount = 0;
  double maxAmount = 0;
  BetServiceProvider._(super.id, super.name, super.image);

  factory BetServiceProvider.fromString(String data) {
    return allMap[data] ?? BetServiceProvider._(data, data, NbImage.buyAirtime);
  }

  static BetServiceProvider sportybet =
      BetServiceProvider._("SPORTYBET", "Sporty Bet", NbImage.sportyBet);
  static BetServiceProvider merrybet =
      BetServiceProvider._("MERRYBET", "Merrybet", NbImage.merryBet);
  static BetServiceProvider betway =
      BetServiceProvider._("BETWAY", "Betway", NbImage.betWay);
  static BetServiceProvider betking =
      BetServiceProvider._("BETKING", "Betking", NbImage.betKing);
  static BetServiceProvider betnaija =
      BetServiceProvider._("BET9JA", "Bet9ja", NbImage.bet9ja);
  static BetServiceProvider oneXBet =
      BetServiceProvider._("ONE_XBET", "1XBet", NbImage.oneXBet);
  static BetServiceProvider nairabet =
      BetServiceProvider._("NAIRABET", "Nairabet", NbImage.nairaBet);

  void updateAmount(double minAmount, double maxAmount) {
    this.minAmount = minAmount;
    this.maxAmount = maxAmount;
  }

  static List<BetServiceProvider> all = [
    sportybet,
    merrybet,
    betway,
    betking,
    betnaija,
    oneXBet,
    nairabet,
  ];

  static Map<String, BetServiceProvider> allMap = {
    sportybet.id: sportybet,
    merrybet.id: merrybet,
    betway.id: betway,
    betking.id: betking,
    betnaija.id: betnaija,
    oneXBet.id: oneXBet,
    nairabet.id: nairabet,
  };

  final String betMinError = "This is below the minimum betting amount";
  final String betMaxError = "This is above the maximum betting amount";
}

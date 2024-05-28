import 'dart:math';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_plan.dart';

class DataPlan extends AbstractServicePlan {
  DataPlan({
    required super.provider,
    required super.name,
    required super.price,
  });

  static String _sizeString(double dataSize) {
    if (dataSize >= 1000 && dataSize < 1000000) {
      return "${(dataSize / 1000).round()} KB";
    } else if (dataSize >= 1000000 && dataSize < 1000000000) {
      return "${(dataSize / 1000000).round()} MB";
    } else if (dataSize >= 1000000000) {
      return "${(dataSize / 1000000000).round()} TB";
    } else {
      return "${dataSize.round()} byte";
    }
  }

  String get priceString => "N${price.round()}";

  static List<DataPlan> sample(MobileServiceProvider mobileProvider) {
    return List.generate(
      8,
      (index) => DataPlan(
          provider: mobileProvider,
          name:
              "${mobileProvider.name} ${_sizeString(pow(10, index + 6) * 0.5)}",
          price: (1 + index) * 50),
    );
  }
}

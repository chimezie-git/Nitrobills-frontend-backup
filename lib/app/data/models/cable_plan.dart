import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_plan.dart';

class CablePlan extends AbstractServicePlan {
  CablePlan({
    required super.provider,
    required super.name,
    required super.price,
  });

  static List<CablePlan> sample(TvServiceProvider provider) {
    return List.generate(
      9,
      (index) => CablePlan(
          provider: provider,
          name: "Plan ${1 + index}",
          price: (1 + index) * 50),
    );
  }
}

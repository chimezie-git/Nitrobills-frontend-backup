import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';

abstract class AbstractServicePlan {
  final AbstractServiceProvider provider;
  final String name;
  final double price;

  AbstractServicePlan({
    required this.provider,
    required this.name,
    required this.price,
  });
}

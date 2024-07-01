import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';

abstract class AbstractServicePlan {
  final int planId;
  final String name;
  final double amount;

  AbstractServicePlan({
    required this.planId,
    required this.name,
    required this.amount,
  });
}

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

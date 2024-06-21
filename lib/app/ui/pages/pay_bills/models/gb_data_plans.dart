import 'package:nitrobills/app/data/provider/abstract_service_plan.dart';

class GbDataPlans extends AbstractServicePlan {
  static const String _idKey = "id";
  static const String _dataIdKey = "data_type_id";
  static const String _nameKey = "name";
  static const String _amountKey = "amount";

  final int id;

  GbDataPlans({
    required this.id,
    required super.planId,
    required super.name,
    required super.amount,
  });

  factory GbDataPlans.fromJson(Map json) => GbDataPlans(
        id: json[_idKey],
        planId: json[_dataIdKey],
        amount: double.parse(json[_amountKey]),
        name: json[_nameKey],
      );
}

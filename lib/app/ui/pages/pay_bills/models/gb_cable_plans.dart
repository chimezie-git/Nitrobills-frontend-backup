import 'package:nitrobills/app/data/provider/abstract_service_plan.dart';

class GbCablePlans extends AbstractServicePlan {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _amountKey = "amount";

  GbCablePlans({
    required super.planId,
    required super.name,
    required super.amount,
  });

  factory GbCablePlans.fromJson(Map json) => GbCablePlans(
        planId: json[_idKey],
        amount: double.parse(json[_amountKey]),
        name: json[_nameKey],
      );
}

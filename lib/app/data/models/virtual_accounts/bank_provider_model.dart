// {"provider_slug": "wema-bank",
//       "bank_id": 20,
//       "bank_name": "Wema Bank",
//       "id": 5}
import 'package:equatable/equatable.dart';

class BankProviderModel extends Equatable {
  static const String _providerSlugKey = "provider_slug";
  static const String _bankIdKey = "bank_id";
  static const String _bankNameKey = "bank_name";
  static const String _idKey = "id";

  final String providerSlug;
  final String bankName;
  final int id;
  final int bankId;

  const BankProviderModel._(
      this.providerSlug, this.bankName, this.id, this.bankId);

  factory BankProviderModel.fromJson(Map<String, dynamic> json) =>
      BankProviderModel._(
        json[_providerSlugKey],
        json[_bankNameKey],
        json[_idKey],
        json[_bankIdKey],
      );

  @override
  List<Object?> get props => [providerSlug, bankName, id, bankId];
}

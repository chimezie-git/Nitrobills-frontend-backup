import 'package:flutter/material.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class Beneficiary {
  static const List<Color> bgColor = [
    Color(0xFF5BF0C3),
    Color(0xFF897AE5),
    Color(0xFF897AE5),
    Color(0xFF7E2A3E),
  ];

  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _providerKey = "provider";
  static const String _userCodeKey = "user_code";
  static const String _lastPaymentKey = "last_payment";
  static const String _transactionTypeKey = "transaction_type";
  static const String _colorIdKey = "color_id";
  static const String _avatarIdKey = "avatar_id";

  final int id;
  final String name;

  /// called transaction type in the server
  final ServiceTypesEnum serviceType;
  final int colorId;
  final int avatarId;
  final String provider;
  final String code;
  final Transaction? lastPayment;

  Beneficiary({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.provider,
    required this.code,
    required this.colorId,
    required this.avatarId,
    required this.lastPayment,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    final serviceType = ServiceTypesEnum.fromServer(json[_transactionTypeKey]);
    Transaction? lastPay = json[_lastPaymentKey] == null
        ? null
        : Transaction.fromJson(
            Map<String, dynamic>.from(json[_lastPaymentKey]));
    return Beneficiary(
      id: json[_idKey],
      name: json[_nameKey],
      serviceType: serviceType,
      colorId: json[_colorIdKey],
      avatarId: json[_avatarIdKey],
      provider: json[_providerKey],
      code: json[_userCodeKey],
      lastPayment: lastPay,
    );
  }

  Color get color => bgColor[colorId];
  Widget get avatar {
    if (avatarId == 0) {
      return NbText.sp28(name[0].toUpperCase()).w500.black;
    } else if (avatarId == 1) {
      return Image.asset(NbImage.avatar1);
    } else {
      return Image.asset(NbImage.avatar2);
    }
  }

  AbstractServiceProvider get serviceProvider =>
      AbstractServiceProvider.fromServer(provider, serviceType);

  static Widget avatarImage(int idx) {
    if (idx == 0) {
      return NbText.sp28("A").w500.black;
    } else if (idx == 1) {
      return Image.asset(NbImage.avatar1);
    } else {
      return Image.asset(NbImage.avatar2);
    }
  }
}

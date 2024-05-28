import 'package:nitrobills/app/data/models/mobile_service_provider.dart';

class PhoneNumber {
  final String number;
  final MobileServiceProvider provider;

  PhoneNumber({
    required this.number,
    required this.provider,
  });
}

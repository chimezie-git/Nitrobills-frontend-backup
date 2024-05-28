import 'package:nitrobills/app/data/models/mobile_service_provider.dart';

class ContactNumber {
  final String number;
  final MobileServiceProvider provider;
  final String name;
  ContactNumber({
    required this.number,
    required this.provider,
    required this.name,
  });

  String get shortNum {
    int numLen = number.length;
    return "***${number.substring(numLen - 4)}";
  }

  static List<ContactNumber> sample = [
    ContactNumber(
        number: "23423423", provider: MobileServiceProvider.mtn, name: "James"),
    ContactNumber(
        number: "23423423", provider: MobileServiceProvider.glo, name: "Luke"),
    ContactNumber(
        number: "23423423",
        provider: MobileServiceProvider.airtel,
        name: "Mark"),
  ];
}

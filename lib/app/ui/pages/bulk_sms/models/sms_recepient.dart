import 'package:equatable/equatable.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class SmsRecepient extends Equatable {
  final String number;
  final bool isContact;
  final String name;

  const SmsRecepient({
    required this.number,
    required this.isContact,
    required this.name,
  });

  factory SmsRecepient.phone(String phone) =>
      SmsRecepient(number: phone, isContact: false, name: phone);
  factory SmsRecepient.contact(PhoneContact contact) {
    String phone = contact.phoneNumber?.number ?? "";
    String name = contact.fullName ?? "";
    phone = phone.replaceAll(" ", "");
    return SmsRecepient(number: phone, isContact: true, name: name);
  }

  @override
  List<Object?> get props => [number, isContact, name];
}

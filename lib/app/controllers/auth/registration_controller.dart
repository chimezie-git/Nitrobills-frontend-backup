import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  //
  FirebaseAuth auth = FirebaseAuth.instance;

  // ui data fields
  final RxString firstname = RxString('');
  final RxString lastname = RxString('');
  final RxString username = RxString('');
  final RxString email = RxString('');
  final RxString phoneNumber = RxString('');
  final RxString password = RxString('');
  final RxString referralCode = RxString('');

  bool verifyRegistrationFields() {
    return firstname.isNotEmpty && lastname.isNotEmpty && username.isNotEmpty;
  }

  Future register() async {
    // check if username exists on the cloud database
  }

  Future verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber.value,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    // FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(newEmail);
    // FirebaseAuth.instance.currentUser?.ph;
  }
}

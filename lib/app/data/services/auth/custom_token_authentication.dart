import 'package:firebase_auth/firebase_auth.dart';

class CustomTokenAuthentication {
  static Future register() async {
    // Firebase
  }

  static Future auth(String token) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(token);
      print("Sign-in successful.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-custom-token":
          print("The supplied token is not a Firebase custom auth token.");
          break;
        case "custom-token-mismatch":
          print("The supplied token is for a different Firebase project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }
}

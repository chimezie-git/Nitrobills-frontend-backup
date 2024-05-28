import 'package:firebase_auth/firebase_auth.dart';
import 'package:nitrobills/app/data/services/firestore/firestore_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class AuthService {
  static const String _collection = "user";

  static AsyncOrError<bool> verifyUsername({required String username}) async {
    final data = await FirestoreService.dataExists(_collection, username);
    return data;
  }

  static Future register({
    required String email,
    required String password,
    required String userName,
  }) async {
    final UserCredential account = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    account.user?.updateDisplayName(userName);
  }

  static Future updateReferral() async {
    // FirestoreService.
  }
}

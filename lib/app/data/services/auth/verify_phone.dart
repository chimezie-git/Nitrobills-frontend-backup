import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class PhoneVerifyData {
  final PhoneAuthCredential? credential;
  final String? verifyId;

  PhoneVerifyData({this.credential, this.verifyId});

  factory PhoneVerifyData.withId(String id) => PhoneVerifyData(verifyId: id);
  factory PhoneVerifyData.withCredential(PhoneAuthCredential credential) =>
      PhoneVerifyData(credential: credential);
}

class VerifyPhone {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static AsyncOrError<PhoneVerifyData> sendCode(String phoneNumber) async {
    try {
      PhoneAuthCredential? credential;
      String? verifyId;
      bool error = true;
      String errorMsg = "code Failed";

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          error = false;
          credential = credential;
        },
        verificationFailed: (FirebaseAuthException e) {
          error = true;
          errorMsg = e.message ?? "";
        },
        codeSent: (String verificationId, int? resendToken) async {
          error = false;
          verifyId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          error = false;
          verifyId = verificationId;
        },
      );
      if (error) {
        return Left(AppError(errorMsg));
      } else {
        return Right(
            PhoneVerifyData(credential: credential, verifyId: verifyId));
      }
    } on FirebaseException catch (exception) {
      return Left(AppError(exception.message ?? ""));
    }
  }

  static AsyncOrError verifyCodeAndSignin(
      String smsCode, verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await auth.signInWithCredential(credential);
      return const Right(null);
    } on FirebaseAuthException catch (authExcept) {
      return Left(AppError(authExcept.message ?? ""));
    } on FirebaseException catch (fireExcept) {
      return Left(AppError(fireExcept.message ?? ""));
    }
  }
}

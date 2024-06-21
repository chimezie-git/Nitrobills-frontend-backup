import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/auth/auth_service.dart';
import 'package:nitrobills/app/data/services/formatter.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/hive_box/auth_data/auth_data.dart';
import 'package:nitrobills/app/ui/pages/auth/change_password_page.dart';
import 'package:nitrobills/app/ui/pages/auth/otp_code_verification.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/pages/home/home_page.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AuthRepo {
  Future<void> changePassword(String password) async {
    final result = await AuthService.changePassword(password);
    if (result.isRight) {
      Navigator.popUntil(Get.context!, (route) => route.isFirst);
      NbToast.info(result.right);
    } else {
      NbToast.error(result.left.message);
    }
  }

  Future<NullOrSingleFieldError> confirmOtp(
      String otp, String phoneNum, bool resetPassword, bool fromHome) async {
    final response = await AuthService.confirmOtp(phoneNum, otp);
    if (response.isRight) {
      if (resetPassword) {
        Get.find<UserAccountController>().authToken.value = response.right;
        AuthModal.showWithoutPop(const ChangePasswordPage());
      } else if (fromHome) {
        Get.find<UserAccountController>().reload();
        Get.back();
      } else {
        _gotToHome();
      }
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> sendOtpSMS(
      String phoneNumber, bool resetPassword) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      NbToast.error(e.toString());
      return const Right(null);
    }
    final response = await AuthService.sendOTPSMS(phone);
    if (response.isRight) {
      if (resetPassword) {
        AuthModal.showWithoutPop(OtpCodeVerificationPage(
          phoneNumber: phone,
          resetPassword: resetPassword,
        ));
      } else {
        Get.back(result: phoneNumber);
      }
      NbToast.success(response.right);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(response.left.message);
      return const Right(null);
    }
  }

  Future<void> resendOtp(String phoneNumber) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      NbToast.error(e.toString());
      return;
    }
    final response = await AuthService.sendOTPSMS(phone);
    if (response.isRight) {
      NbToast.success(response.right);
    } else {
      NbToast.error(response.left.message);
    }
  }

  Future<NullOrSingleFieldError> sendOtpEmail(String email) async {
    final response = await AuthService.sendOTPEmail(email);
    if (response.isRight) {
      NbToast.success(response.right);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> changeEmail(String email) async {
    final response = await AuthService.changeEmail(email);
    if (response.isRight) {
      NbToast.success(response.right);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(response.left.message);
      return const Right(null);
    }
  }

  Future<void> resendEmailVerification() async {
    final response = await AuthService.resendEmailVerification();
    if (response.isRight) {
      NbToast.success(response.right);
    } else {
      NbToast.error(response.left.message);
    }
  }

  Future<NullOrMultipleFieldError> register(
    String username,
    String firstName,
    String lastName,
    String password,
    String email,
    String phoneNumber,
    String referalCode,
  ) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      return Left(MultipleFieldError([("phone_number", e.toString())], ""));
    }
    final response = await AuthService.register(
        email: email,
        password: password,
        userName: username,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phone,
        referralCode: referalCode);

    if (response.isRight) {
      Get.find<UserAccountController>().authToken.value = response.right;
      await _saveLoginPassword(email, password);
      AuthModal.showWithoutPop(OtpCodeVerificationPage(phoneNumber: phone));
      return const Right(null);
    } else if (response.left is MultipleFieldError) {
      return Left(response.left as MultipleFieldError);
    } else {
      NbToast.error(response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> login(
      String emailUsername, String password) async {
    final request = await AuthService.login(
        emailUsername: emailUsername, password: password);
    if (request.isRight) {
      Get.find<UserAccountController>().authToken.value = request.right;
      await _saveLoginPassword(emailUsername, password);
      _gotToHome();
      return const Right(null);
    } else if (request.left is SingleFieldError) {
      return Left(request.left as SingleFieldError);
    } else {
      NbToast.error(request.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> onlyPasswordLogin(String password) async {
    final cntrl = Get.find<AuthController>();
    return await login(cntrl.email.value, password);
  }

  Future<NullOrSingleFieldError> biometricLogin() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool loggedIn = await auth.authenticate(
        localizedReason: 'Use Thumbprint to access Nitro bills',
        options: const AuthenticationOptions(biometricOnly: true));
    if (loggedIn) {
      final cntrl = Get.find<AuthController>();
      return await login(cntrl.email.value, cntrl.password.value);
    } else {
      NbToast.error("biometric Login Failed");
      return const Right(null);
    }
  }

  Future<void> skipVerification() async {
    _gotToHome();
  }

  void _gotToHome() {
    NbUtils.setNavIndex(0);
    Get.offAll(() => const HomePage());
  }

  Future<void> _saveLoginPassword(String email, String password) async {
    final now = DateTime.now();
    Get.find<AuthController>().password.value = password;
    Get.find<AuthController>().email.value = email;
    Get.find<AuthController>().lastLogin.value = now;
    await AuthData.updateData(
      password: password,
      email: email,
      lastLogin: now,
    );
  }
}

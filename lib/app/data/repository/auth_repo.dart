// ignore_for_file: use_build_context_synchronously

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
import 'package:nitrobills/app/ui/pages/auth/pin_code_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/pages/home/home_page.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AuthRepo {
  Future<void> changePassword(BuildContext context, String password) async {
    final result = await AuthService.changePassword(password);
    if (result.isRight) {
      Navigator.popUntil(Get.context!, (route) => route.isFirst);
      NbToast.info(context, result.right);
    } else {
      NbToast.error(context, result.left.message);
    }
  }

  Future<NullOrSingleFieldError> confirmOtpPhone(BuildContext context,
      String otp, String phoneNum, bool resetPassword) async {
    final response = await AuthService.confirmOtpPhone(phoneNum, otp);
    if (response.isRight) {
      Get.find<UserAccountController>().authToken.value = response.right;
      if (resetPassword) {
        AuthModal.showWithoutPop(const ChangePasswordPage());
      } else {
        Get.to(
          const PinCodePage(),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      }
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> sendOtpSMS(
      BuildContext context, String phoneNumber) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      NbToast.error(context, e.toString());
      return const Right(null);
    }
    final response = await AuthService.sendOTPSMS(phone);
    if (response.isRight) {
      NbToast.success(context, response.right);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<void> resendOtp(BuildContext context, String phoneNumber) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      NbToast.error(context, e.toString());
      return;
    }
    final response = await AuthService.sendOTPSMS(phone);
    if (response.isRight) {
      NbToast.success(context, response.right);
    } else {
      NbToast.error(context, response.left.message);
    }
  }

  Future<NullOrSingleFieldError> sendOtpEmail(
      BuildContext context, String email) async {
    final response = await AuthService.sendOTPEmail(email);
    if (response.isRight) {
      NbToast.success(context, response.right);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> changeEmail(
      BuildContext context, String email) async {
    final response = await AuthService.changeEmail(email);
    if (response.isRight) {
      NbToast.success(context, response.right);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<void> resendEmailVerification(
    BuildContext context,
  ) async {
    final response = await AuthService.resendEmailVerification();
    if (response.isRight) {
      NbToast.success(context, response.right);
    } else {
      NbToast.error(context, response.left.message);
    }
  }

  Future<NullOrMultipleFieldError> register(
    BuildContext context,
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
      await _saveLoginPassword(email, password);
      AuthModal.showWithoutPop(OtpCodeVerificationPage(
        phoneNumber: phone,
        email: email,
        username: username,
        resetPassword: false,
      ));
      return const Right(null);
    } else if (response.left is MultipleFieldError) {
      return Left(response.left as MultipleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> login(
      BuildContext context, String emailUsername, String password) async {
    final request = await AuthService.login(
        emailUsername: emailUsername, password: password);
    if (request.isRight) {
      final data = request.right;
      if (data['verified'] ?? false) {
        Get.find<UserAccountController>().authToken.value = data["key"];
        await _saveLoginPassword(emailUsername, password);
        _gotToHome();
      } else {
        String username = data["username"];
        String email = data["email"];
        String phoneNumber = data["phone_number"];
        AuthModal.showWithoutPop(
          OtpCodeVerificationPage(
            phoneNumber: phoneNumber,
            email: email,
            username: username,
            resetPassword: false,
            showBack: true,
          ),
        );
      }
      return const Right(null);
    } else if (request.left is SingleFieldError) {
      return Left(request.left as SingleFieldError);
    } else {
      NbToast.error(context, request.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> onlyPasswordLogin(
      BuildContext context, String password) async {
    final cntrl = Get.find<AuthController>();
    return await login(context, cntrl.email.value, password);
  }

  Future<NullOrSingleFieldError> biometricLogin(
    BuildContext context,
  ) async {
    final LocalAuthentication auth = LocalAuthentication();
    bool loggedIn = await auth.authenticate(
        localizedReason: 'Use Thumbprint to access Nitro bills',
        options: const AuthenticationOptions(biometricOnly: true));
    if (loggedIn) {
      final cntrl = Get.find<AuthController>();
      return await login(context, cntrl.email.value, cntrl.password.value);
    } else {
      NbToast.error(context, "biometric Login Failed");
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> changePhoneNumber(
    BuildContext context,
    String phoneNumber,
    String email,
    String username,
  ) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      NbToast.error(context, e.toString());
      return const Right(null);
    }
    final response = await AuthService.changePhoneNumber(
        email: email, phone: phone, username: username);
    if (response.isRight) {
      NbToast.success(context, response.right);
      Get.back(result: phoneNumber);
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<NullOrSingleFieldError> forgetPassword(
      BuildContext context, String phoneNumber) async {
    final String phone;
    try {
      phone = NbFormatter.phone(phoneNumber);
    } catch (e) {
      NbToast.error(context, e.toString());
      return const Right(null);
    }
    final response = await AuthService.forgetPassword(phone: phone);
    if (response.isRight) {
      String username = response.right["username"];
      String email = response.right["email"];
      AuthModal.showWithoutPop(
        OtpCodeVerificationPage(
            phoneNumber: phoneNumber,
            email: email,
            username: username,
            resetPassword: true),
      );
      return const Right(null);
    } else if (response.left is SingleFieldError) {
      return Left(response.left as SingleFieldError);
    } else {
      NbToast.error(context, response.left.message);
      return const Right(null);
    }
  }

  Future<void> setPin(BuildContext context, String pin) async {
    final response = await AuthService.setPin(pin: pin);
    if (response.isRight) {
      _gotToHome();
    } else {
      NbToast.error(context, response.left.message);
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

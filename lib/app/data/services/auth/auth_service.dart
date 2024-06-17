import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class AuthService {
  static const String _baseUrl =
      "https://nitrobills-backend.onrender.com/api/auth/";

  /// signin with Username/Email and Password returns token or error
  static AsyncOrError<String> login({
    required String emailUsername,
    required String password,
  }) async {
    Map<String, dynamic> payload = {
      "username": emailUsername,
      "password": password,
    };
    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}login/", payload);
    if (response.isRight) {
      if (response.right.statusCode == 200) {
        String token = response.right.data["key"];
        return Right(token);
      } else if (response.right.data["non_field_errors"] != null) {
        return Left(SingleFieldError(
            "field", response.right.data["non_field_errors"][0]));
      } else {
        return Left(
            AppError(Map.from(response.right.data).values.first.toString()));
      }
    } else {
      return Left(response.left);
    }
  }

  ///register user returns token or error
  static AsyncOrError<String> register({
    required String email,
    required String password,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? referralCode,
  }) async {
    Map<String, dynamic> payload = {
      "username": userName,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password1": password,
      "password2": password,
      "email_verified": false,
      "phone_verified": false,
      "phone_number": phoneNumber,
      "referral_code": referralCode,
    };
    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}register/", payload);

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        String token = response.right.data["key"];
        return Right(token);
      } else {
        List keys = ["email", "username", "phone_number", "password1"];
        bool keyError = false;
        Map<String, dynamic> mapData = response.right.data;
        List<(String, String)> fieldMessages = [];
        for (String key in keys) {
          if (mapData.keys.contains(key)) {
            keyError = true;
            fieldMessages.add((key, mapData["key"][0].toString()));
          }
        }
        if (keyError) {
          return Left(MultipleFieldError(fieldMessages, "field"));
        } else {
          return Left(
              AppError(Map.from(response.right.data).values.first.toString()));
        }
      }
    } else {
      return Left(response.left);
    }
  }

  /// signin with Phone Credential returns token key or error
  static AsyncOrError<String> confirmOtp(String phone, String otpCode) async {
    Map<String, dynamic> payload = {"otp_code": otpCode, "phone_number": phone};

    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}confirm_otp/", payload);
    if (response.isRight) {
      if (response.right.statusCode == 200) {
        return Right(response.right.data["key"]);
      } else {
        String msg = response.right.data["msg"];
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// send Otp SMS returns success message or error
  static AsyncOrError<String> sendOTPSMS(String phone) async {
    Map<String, dynamic> payload = {"phone_number": phone};
    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}send_sms_otp/", payload);
    if (response.isRight) {
      String msg = response.right.data["message"];
      if (response.right.statusCode == 200) {
        return Right(msg);
      } else {
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// send Otp Email returns success message or error
  static AsyncOrError<String> sendOTPEmail(String email) async {
    Map<String, dynamic> payload = {"email": email};

    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}send_email_otp/", payload);
    if (response.isRight) {
      String msg = response.right.data["msg"];
      if (response.right.statusCode == 200) {
        return Right(msg);
      } else {
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// update password return success message or error
  static AsyncOrError<String> changePassword(String newPassword) async {
    Map<String, dynamic> payload = {"password": newPassword};
    String token = Get.find<UserAccountController>().authToken.value;

    TypeOrError<dio.Response> response =
        await HttpService.put("${_baseUrl}change_password/", payload, header: {
      "Content-Type": "application/json",
      "Authorization": "Token $token",
    });

    if (response.isRight) {
      String msg = response.right.data["msg"];
      if (response.right.statusCode == 200) {
        return Right(msg);
      } else {
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<void> logout() async {
    return const Right(null);
  }
}

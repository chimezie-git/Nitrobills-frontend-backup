import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class AuthService {
  static String get _baseUrl => "${NbUtils.baseUrl}/api/auth/";

  static String _listDictString(var val) {
    if (val is List) {
      return val.first.toString();
    } else if (val is Map) {
      return val.values.first.toString();
    } else {
      return val.toString();
    }
  }

  static String _stringFromMap(Map data) {
    final val = data.values.first;
    if (val is List) {
      return val.first.toString();
    } else if (val is Map) {
      return val.values.first.toString();
    } else {
      return val.toString();
    }
  }

  /// signin with Username/Email and Password returns token or error
  static AsyncOrError<Map> login({
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
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData);
      } else if (responseData.containsKey("non_field_errors")) {
        return Left(
          SingleFieldError(
            "field",
            _listDictString(responseData["non_field_errors"]),
          ),
        );
      } else {
        return Left(AppError(_stringFromMap(responseData)));
      }
    } else {
      return Left(response.left);
    }
  }

  ///register user returns token or error
  static AsyncOrError<Map> register({
    required String email,
    required String password,
    required String userName,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String referralCode,
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
      if (referralCode.isNotEmpty) "referral_code": referralCode,
    };
    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}register/", payload);

    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200 ||
          response.right.statusCode == 201) {
        return Right(responseData);
      } else {
        List keys = [
          "username",
          "email",
          "first_name",
          "last_name",
          "password1",
          "password2",
          "phone_number",
          "referral_code"
        ];
        bool keyError = false;
        List<(String, String)> fieldMessages = [];
        for (String key in keys) {
          if (responseData.containsKey(key)) {
            keyError = true;
            fieldMessages.add(
              (key, _listDictString(responseData[key])),
            );
          }
        }
        if (keyError) {
          return Left(MultipleFieldError(fieldMessages, "Input Errors"));
        } else {
          return Left(AppError(_stringFromMap(responseData)));
        }
      }
    } else {
      return Left(response.left);
    }
  }

  /// signin with Phone Credential returns token key or error
  static AsyncOrError<String> confirmOtpPhone(
      String phone, String otpCode) async {
    Map<String, dynamic> payload = {"otp_code": otpCode, "phone_number": phone};

    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}confirm_otp/phone/", payload);
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData["key"]);
      } else if (responseData.containsKey("otp")) {
        String msg = responseData["otp"];
        return Left(SingleFieldError("", msg));
      } else {
        String msg = _stringFromMap(responseData);
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// signin with Phone Credential returns token key or error
  static AsyncOrError<void> confirmOtpPin(String email, String otpCode) async {
    Map<String, dynamic> payload = {"otp_code": otpCode, "email": email};

    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}confirm_otp/pin/", payload);
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return const Right(null);
      } else if (responseData.containsKey("otp")) {
        String msg = responseData["otp"];
        return Left(SingleFieldError("", msg));
      } else {
        String msg = _stringFromMap(responseData);
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
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData["msg"]);
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(SingleFieldError("", msg));
      } else {
        String msg = _stringFromMap(responseData);
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
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData["msg"]);
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(SingleFieldError("", msg));
      } else {
        String msg = _stringFromMap(responseData);
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// change Email returns success message or error
  static AsyncOrError<String> changeEmail(String email) async {
    Map<String, dynamic> payload = {"email": email};

    TypeOrError<dio.Response> response = await HttpService.post(
        "${_baseUrl}email/change/", payload,
        header: _loginHeader());
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData["msg"]);
      } else if (responseData.containsKey("email")) {
        String msg = responseData["email"];
        return Left(SingleFieldError("", msg));
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(SingleFieldError("", msg));
      } else {
        String msg = _stringFromMap(responseData);
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// send Otp Email returns success message or error
  static AsyncOrError<String> resendEmailVerification() async {
    TypeOrError<dio.Response> response = await HttpService.post(
        "${_baseUrl}email/verify/", null,
        header: _loginHeader());
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData["msg"]);
      } else if (responseData.containsKey("msg")) {
        String msg = responseData["msg"];
        return Left(SingleFieldError("", msg));
      } else {
        String msg = _stringFromMap(responseData);
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  /// update password return success message or error
  static AsyncOrError<String> changePassword(String newPassword) async {
    Map<String, dynamic> payload = {"password": newPassword};

    TypeOrError<dio.Response> response = await HttpService.post(
        "${_baseUrl}password_change/", payload,
        header: _loginHeader());

    if (response.isRight) {
      if (response.right.statusCode == 200) {
        Map responseData = Map.from(response.right.data);
        return Right(responseData["msg"]);
      } else if (response.right.data.containsKey("msg")) {
        String msg = response.right.data["msg"];
        return Left(AppError(msg));
      } else {
        String msg = _stringFromMap(response.right.data);
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<void> logout() async {
    return const Right(null);
  }

  static AsyncOrError<String> changePhoneNumber({
    required String email,
    required String username,
    required String phone,
  }) async {
    Map<String, dynamic> payload = {
      "username": username,
      "email": email,
      "phone_number": phone,
    };
    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}change_phone/", payload);
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData["msg"]);
      } else if (responseData.containsKey("phone")) {
        return Left(
          SingleFieldError(
            "field",
            _listDictString(responseData["phone"]),
          ),
        );
      } else {
        return Left(AppError(_stringFromMap(responseData)));
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<Map> forgetPassword({
    required String phone,
  }) async {
    Map<String, dynamic> payload = {
      "phone_number": phone,
    };
    TypeOrError<dio.Response> response =
        await HttpService.post("${_baseUrl}forget_password/", payload);
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData);
      } else if (responseData.containsKey("phone")) {
        return Left(
          SingleFieldError(
            "field",
            _listDictString(responseData["phone"]),
          ),
        );
      } else {
        return Left(AppError(_stringFromMap(responseData)));
      }
    } else {
      return Left(response.left);
    }
  }

  static AsyncOrError<String> setPin({
    required String pin,
  }) async {
    Map<String, dynamic> payload = {
      "pin": pin,
    };
    TypeOrError<dio.Response> response = await HttpService.post(
        "${_baseUrl}pin_code/update/", payload,
        header: _loginHeader());
    if (response.isRight) {
      Map responseData = Map.from(response.right.data);
      if (response.right.statusCode == 200) {
        return Right(responseData['msg']);
      } else {
        return Left(AppError(_stringFromMap(responseData)));
      }
    } else {
      return Left(response.left);
    }
  }

  static Map<String, dynamic> _loginHeader() {
    String token = Get.find<UserAccountController>().authToken.value;

    return {
      "Content-Type": "application/json",
      "Authorization": "Token $token",
    };
  }
}

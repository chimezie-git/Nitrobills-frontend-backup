import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/repository/auth_repo.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/auth/edit_phone_number_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCodeVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String username;
  final bool resetPassword;
  final bool showBack;
  const OtpCodeVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.email,
    required this.username,
    required this.resetPassword,
    this.showBack = false,
  });

  @override
  State<OtpCodeVerificationPage> createState() =>
      _OtpCodeVerificationPageState();
}

class _OtpCodeVerificationPageState extends State<OtpCodeVerificationPage> {
  String otpCode = '';
  ValueNotifier<ButtonEnum> buttonStatus = ValueNotifier(ButtonEnum.disabled);
  late String phoneNumber;
  bool otpError = false;
  String? otpErrorText;

  Color get fieldBorderColor => otpError ? NbColors.red : Colors.grey;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.phoneNumber;
  }

  @override
  void dispose() {
    buttonStatus.value;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 1.h,
            left: 5.w,
            right: 5.w,
            height: 110.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xFF434242),
              ),
            ),
          ),
          Positioned(
            top: 10.h,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: NbColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 12.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.resetPassword || widget.showBack)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: NbButton.backIcon(_back),
                      )
                    else
                      24.verticalSpace,
                    23.verticalSpace,
                    NbText.sp22("Enter Verification Code").w500.darkGrey,
                    32.verticalSpace,
                    NbText.sp16(
                            "An SMS with a verification code has been sent to your phone")
                        .w500
                        .setColor(const Color(0xFF2F3336))
                        .centerText,
                    24.verticalSpace,
                    RichText(
                      text: TextSpan(
                        text: "${_format(phoneNumber)}  ",
                        style: TextStyle(
                            color: const Color(0xFF2F3336),
                            fontSize: 16.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: "Edit?",
                            style: const TextStyle(
                              color: Color(0xFF1E92E9),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Satoshi',
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _editPhoneNumber,
                          )
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: PinCodeTextField(
                        scrollPadding: EdgeInsets.zero,
                        onChanged: (v) {
                          if (v.length < 6) {
                            buttonStatus.value = ButtonEnum.disabled;
                          } else {
                            buttonStatus.value = ButtonEnum.active;
                          }
                          otpCode = v;
                          _clearForcedErrors();
                        },
                        keyboardType: TextInputType.number,
                        appContext: context,
                        obscureText: true,
                        animationDuration: const Duration(milliseconds: 200),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        blinkDuration: const Duration(milliseconds: 1200),
                        obscuringWidget: SvgPicture.asset(
                          NbSvg.obscure,
                          height: 20.r,
                        ),
                        length: 6,
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F3336),
                        ),
                        pinTheme: PinTheme(
                          fieldOuterPadding: EdgeInsets.zero,
                          selectedColor: fieldBorderColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12.r),
                          fieldHeight: 46.r,
                          fieldWidth: 46.r,
                          activeColor: fieldBorderColor,
                          inactiveFillColor: fieldBorderColor,
                          activeFillColor: fieldBorderColor,
                          inactiveColor: fieldBorderColor,
                        ),
                      ),
                    ),
                    if (otpErrorText != null)
                      NbText.sp12(otpErrorText!).setColor(fieldBorderColor),
                    10.verticalSpace,
                    RichText(
                      text: TextSpan(
                        text: "Didn't recieve a code? ",
                        style: TextStyle(
                            color: const Color(0xFF282828),
                            fontSize: 16.sp,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: "Request Again",
                            style: const TextStyle(
                              color: Color(0xFF595C5E),
                              fontFamily: 'Satoshi',
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _requestAgain,
                          )
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    ValueListenableBuilder(
                        valueListenable: buttonStatus,
                        builder: (context, value, child) {
                          return NbButton.primary(
                            text: "VerifyNumber",
                            onTap: _verifyNumber,
                            status: value,
                          );
                        }),
                    32.verticalSpace,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _back() {
    Get.back();
  }

  void _requestAgain() async {
    buttonStatus.value = ButtonEnum.loading;
    await AuthRepo().resendOtp(
      phoneNumber,
    );
    buttonStatus.value = ButtonEnum.active;
  }

  void _editPhoneNumber() async {
    phoneNumber = await AuthModal.show<String?>(EditPhoneNumberPage(
          username: widget.username,
          email: widget.email,
          phoneNumber: phoneNumber,
        )) ??
        phoneNumber;
    setState(() {});
  }

  void _verifyNumber() async {
    buttonStatus.value = ButtonEnum.loading;
    final result = await AuthRepo()
        .confirmOtpPhone(otpCode, phoneNumber, widget.resetPassword);
    if (result.isLeft) {
      _showErrors(result.left);
    }
    buttonStatus.value = ButtonEnum.active;
  }

  String _format(String phone) {
    return '${phone.substring(0, 4)}-${phone.substring(4, 7)}-${phone.substring(7, 10)}-${phone.substring(10)}';
  }

  void _showErrors(SingleFieldError error) {
    otpError = true;
    otpErrorText = error.message;
    setState(() {});
  }

  void _clearForcedErrors() {
    otpError = false;
    otpErrorText = null;
    setState(() {});
  }
}

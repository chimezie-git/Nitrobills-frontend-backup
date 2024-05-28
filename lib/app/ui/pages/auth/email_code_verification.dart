import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/auth/change_password_page.dart';
import 'package:nitrobills/app/ui/pages/auth/phone_number_page.dart';
import 'package:nitrobills/app/ui/pages/auth/signin_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailCodeVerificationPage extends StatefulWidget {
  const EmailCodeVerificationPage({super.key});

  @override
  State<EmailCodeVerificationPage> createState() =>
      _EmailCodeVerificationPageState();
}

class _EmailCodeVerificationPageState extends State<EmailCodeVerificationPage> {
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: NbButton.backIcon(_back),
                    ),
                    30.verticalSpace,
                    NbText.sp22("Enter Verification Code").w500.darkGrey,
                    20.verticalSpace,
                    NbText.sp16(
                            "An email with a verification ha been ent to your phone")
                        .w500
                        .setColor(const Color(0xFF2F3336))
                        .centerText,
                    20.verticalSpace,
                    RichText(
                      text: TextSpan(
                        text: "+234324234  ",
                        style: TextStyle(
                            color: const Color(0xFF2F3336),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: "Edit?",
                            style: const TextStyle(
                              color: Color(0xFF1E92E9),
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _editPhoneNumber,
                          )
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      appContext: context,
                      obscureText: true,
                      animationDuration: const Duration(milliseconds: 200),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      blinkDuration: const Duration(milliseconds: 1200),
                      obscuringWidget: SvgPicture.asset(
                        NbSvg.obscure,
                        height: 30.r,
                      ),
                      length: 4,
                      textStyle: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2F3336),
                      ),
                      pinTheme: PinTheme(
                        selectedColor: Colors.grey,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(20.r),
                        fieldHeight: 73.r,
                        fieldWidth: 73.r,
                        activeColor: Colors.grey,
                        inactiveFillColor: Colors.grey,
                        activeFillColor: Colors.grey,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    20.verticalSpace,
                    RichText(
                      text: TextSpan(
                        text: "Didn't recieve a code? ",
                        style: TextStyle(
                            color: const Color(0xFF282828),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: "Request Again",
                            style: const TextStyle(
                              color: Color(0xFF595C5E),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _requestAgain,
                          )
                        ],
                      ),
                    ),
                    25.verticalSpace,
                    NbButton.primary(
                        text: "VerifyNumber", onTap: _verifyNumber),
                    30.verticalSpace,
                    TextButton(
                      onPressed: _signin,
                      child:
                          NbText.sp14("Already a member? Signin").w500.darkGrey,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _requestAgain() {}
  void _back() {
    Get.back();
  }

  void _signin() {
    AuthModal.show(const SigninPage());
  }

  void _editPhoneNumber() {
    AuthModal.show(const PhoneNumberPage());
  }

  void _verifyNumber() {
    AuthModal.show(const ChangePasswordPage());
  }
}

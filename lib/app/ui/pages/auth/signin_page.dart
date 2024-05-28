import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/auth/phone_number_page.dart';
import 'package:nitrobills/app/ui/pages/auth/signup_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/previous_signin_card.dart';
import 'package:nitrobills/app/ui/pages/home/home_page.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool hasUser = true;
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
            height: 790.h,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: NbColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NbHeader.backAndTitle("Sign in", _back),
                    30.verticalSpace,
                    hasUser
                        ? PreviousSigninCard(
                            date: DateTime.now(),
                            name: "Tony Joshua",
                            onClose: () {
                              setState(() {
                                hasUser = false;
                              });
                            },
                          )
                        : NbField.text(hint: "Email or username"),
                    20.verticalSpace,
                    NbField.text(hint: "Password"),
                    20.verticalSpace,
                    if (hasUser)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            NbSvg.username,
                            width: 24.r,
                          ),
                          24.horizontalSpace,
                          NbText.sp16("Use Fingerprint")
                              .w500
                              .setColor(const Color(0xFF282828)),
                        ],
                      ),
                    20.verticalSpace,
                    NbButton.primary(text: "Login", onTap: _login),
                    37.verticalSpace,
                    RichText(
                      text: TextSpan(
                        text: "Dont have an account? ",
                        style: TextStyle(
                            color: const Color(0xFF282828),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: const TextStyle(
                              color: Color(0xFF1E92E9),
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _signup,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _forgetPassword,
                      child: NbText.sp14("Forget Password").w500.darkGrey,
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

  void _back() {
    Get.back();
  }

  void _signup() {
    AuthModal.show(const SignupPage());
  }

  void _login() {
    NbUtils.setNavIndex(0);
    Get.offAll(const HomePage());
  }

  void _forgetPassword() {
    AuthModal.show(const PhoneNumberPage());
  }
}

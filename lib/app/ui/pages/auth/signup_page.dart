import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/auth/email_code_verification.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/signup_double_fields.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ValueNotifier<bool> obscurePassword = ValueNotifier(true);

  @override
  void dispose() {
    obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NbHeader.backAndTitle("Sign up", _back),
                      30.verticalSpace,
                      SignupDoubleFields(
                        hint1: "First name",
                        hint2: "Last name",
                      ),
                      8.verticalSpace,
                      NbText.sp12(
                              "This would be used to generate an account to deposit into")
                          .w400,
                      23.verticalSpace,
                      SignupDoubleFields(
                        hint1: "Username",
                        hint2: "Phone Number",
                      ),
                      8.verticalSpace,
                      NbText.sp12("You would need this for recovery access")
                          .w400,
                      23.verticalSpace,
                      ValueListenableBuilder(
                          valueListenable: obscurePassword,
                          builder: (context, obscure, child) {
                            return NbField.textAndIcon(
                              hint: "Password",
                              obscureText: obscure,
                              trailing: InkWell(
                                onTap: () {
                                  obscurePassword.value = !obscure;
                                },
                                child: SvgPicture.asset(
                                    obscure ? NbSvg.visible : NbSvg.notVisible),
                              ),
                            );
                          }),
                      16.verticalSpace,
                      NbField.text(hint: "Referral Code (Optional)"),
                      20.verticalSpace,
                      RichText(
                        text: TextSpan(
                          text:
                              "By selecting Agree and continue, i agree to Nitro bills pay’s Terms of service, and also acknowledge the",
                          style: TextStyle(
                              color: const Color(0xFF2F3336),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                          children: [
                            TextSpan(
                              text: " Privacy Policy.",
                              style: const TextStyle(
                                  color: Color(0xFF1E92E9),
                                  fontWeight: FontWeight.w400),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _privacyPolicy,
                            )
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      NbButton.primary(
                          text: "Agree and continue", onTap: _agreeAndContinue),
                      37.verticalSpace,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _back() {
    Get.back();
  }

  void _privacyPolicy() {}

  void _agreeAndContinue() {
    AuthModal.show(const EmailCodeVerificationPage());
  }
}

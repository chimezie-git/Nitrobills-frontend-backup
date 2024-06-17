import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/repository/auth_repo.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/global_widgets/form_fields.dart';
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
  ValueNotifier<ButtonEnum> buttonStatus = ValueNotifier(ButtonEnum.active);
  late TextEditingController firstNameCntrl;
  late TextEditingController lastNameCntrl;
  late TextEditingController usernameCntrl;
  late TextEditingController emailCntrl;
  late TextEditingController passwordCntrl;
  late TextEditingController phoneCntrl;
  late TextEditingController referralCodeCntrl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameCntrl = TextEditingController();
    lastNameCntrl = TextEditingController();
    usernameCntrl = TextEditingController();
    emailCntrl = TextEditingController();
    passwordCntrl = TextEditingController();
    phoneCntrl = TextEditingController();
    referralCodeCntrl = TextEditingController();
  }

  @override
  void dispose() {
    obscurePassword.dispose();
    buttonStatus.dispose();
    firstNameCntrl.dispose();
    lastNameCntrl.dispose();
    usernameCntrl.dispose();
    emailCntrl.dispose();
    passwordCntrl.dispose();
    phoneCntrl.dispose();
    referralCodeCntrl.dispose();
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NbHeader.backAndTitle("Sign up", _back),
                        30.verticalSpace,
                        DoubleTextField(
                            firstNameCntrl: firstNameCntrl,
                            lastNameCntrl: lastNameCntrl),
                        8.verticalSpace,
                        NbText.sp12(
                                "This would be used to generate an account to deposit into")
                            .w400
                            .setColor(const Color(0xFF787878)),
                        8.verticalSpace,
                        TrippleTextField(
                          userNameCntrl: usernameCntrl,
                          phoneNumCntrl: phoneCntrl,
                          emailCntrl: emailCntrl,
                        ),
                        8.verticalSpace,
                        NbText.sp12("You would need this for recovery access")
                            .w400
                            .setColor(const Color(0xFF787878)),
                        8.verticalSpace,
                        ValueListenableBuilder(
                            valueListenable: obscurePassword,
                            builder: (context, obscure, child) {
                              return NbField.textAndIcon(
                                controller: passwordCntrl,
                                hint: "Password",
                                obscureText: obscure,
                                validator: () {
                                  if (!NbValidators.isPassword(
                                      passwordCntrl.text)) {
                                    return "Password must be eight characters, with at least one letter and one number";
                                  } else {
                                    return null;
                                  }
                                },
                                trailing: InkWell(
                                  onTap: () {
                                    obscurePassword.value = !obscure;
                                  },
                                  child: SvgPicture.asset(obscure
                                      ? NbSvg.visible
                                      : NbSvg.notVisible),
                                ),
                              );
                            }),
                        27.verticalSpace,
                        NbField.text(
                            controller: referralCodeCntrl,
                            hint: "Referral Code (Optional)"),
                        27.verticalSpace,
                        RichText(
                          text: TextSpan(
                            text:
                                "By selecting Agree and continue, i agree to Nitro bills pay's Terms of service, and also acknowledge the",
                            style: TextStyle(
                              color: const Color(0xFF2F3336),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Satoshi',
                            ),
                            children: [
                              TextSpan(
                                text: " Privacy Policy.",
                                style: const TextStyle(
                                    color: Color(0xFF1E92E9),
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w400),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _privacyPolicy,
                              )
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        ValueListenableBuilder(
                            valueListenable: buttonStatus,
                            builder: (context, value, child) {
                              return NbButton.primary(
                                text: "Agree and continue",
                                onTap: _agreeAndContinue,
                                status: value,
                              );
                            }),
                        37.verticalSpace,
                      ],
                    ),
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

  void _agreeAndContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      buttonStatus.value = ButtonEnum.loading;
      final data = await AuthRepo().register(
        usernameCntrl.text,
        firstNameCntrl.text,
        lastNameCntrl.text,
        passwordCntrl.text,
        emailCntrl.text,
        phoneCntrl.text,
        referralCodeCntrl.text,
      );
      if (data.isLeft) {
        data.left;
      }
      buttonStatus.value = ButtonEnum.active;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/pages/auth/email_code_verification.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  late TextEditingController numberField;
  List<String> numCodes = ["+234", "+229", "+124", "+442"];
  late String numCode;

  @override
  void initState() {
    numberField = TextEditingController();
    numCode = numCodes[0];
    super.initState();
  }

  @override
  void dispose() {
    numberField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
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
              top: 7.h,
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NbButton.backIcon(_back),
                      60.verticalSpace,
                      NbText.sp22("Enter Phone Number").w500.darkGrey,
                      12.verticalSpace,
                      NbText.sp16(
                              "Enter the phone number associated with your aount")
                          .w400
                          .darkGrey,
                      32.verticalSpace,
                      Row(
                        children: [
                          Container(
                            width: 95.w,
                            height: 62.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: NbColors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: const Color(0xFFBBB9B9),
                                width: 1,
                              ),
                            ),
                            child: DropdownButton(
                              value: numCode,
                              items: numCodes
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: NbText.sp16(e).w500.darkGrey,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (code) {
                                setState(() {
                                  numCode = code ?? numCode;
                                });
                              },
                              underline: const SizedBox.shrink(),
                              icon: SvgPicture.asset(
                                NbSvg.arrowDown,
                                width: 13.r,
                              ),
                            ),
                          ),
                          12.horizontalSpace,
                          Expanded(
                              child: NbField.text(
                            hint: "Enter Number",
                            controller: numberField,
                          )),
                        ],
                      ),
                      24.verticalSpace,
                      NbButton.primary(
                          text: "Reset Password", onTap: _resetPassword),
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

  void _resetPassword() {
    AuthModal.show(const EmailCodeVerificationPage());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
                      NbText.sp22("Enter Phone number").w500.darkGrey,
                      12.verticalSpace,
                      NbText.sp16(
                              "Enter the phone number associated with your account")
                          .w400
                          .darkGrey,
                      24.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 62.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFBBB9B9),
                                  width: 1,
                                ),
                              ),
                              child: NbText.sp16("+880"),
                            ),
                          ),
                          12.horizontalSpace,
                          SizedBox(
                            width: 230.w,
                            child: NbField.text(hint: "Enter number"),
                          ),
                        ],
                      ),
                      32.verticalSpace,
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

  void _resetPassword() {}
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/ui/pages/auth/otp_code_verification.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class VerifyPhoneNumberTile extends StatelessWidget {
  const VerifyPhoneNumberTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<UserAccountController>(
      init: Get.find<UserAccountController>(),
      builder: (cntrl) {
        if (cntrl.account.value.phoneVerified) {
          return const SizedBox.shrink();
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: InkWell(
              onTap: _verifyNumber,
              child: Container(
                height: 70.h,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xFFFAD2D2),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      NbSvg.info,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFD12E2E),
                        BlendMode.srcIn,
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: NbText.sp16(
                              "Verify phone number for account recovery")
                          .w600
                          .setColor(const Color(0xFFD12E2E)),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future _verifyNumber() async {
    NbUtils.removeNav;
    await AuthModal.showWithoutPop(OtpCodeVerificationPage(
      phoneNumber: Get.find<AuthController>().phoneNumber.value,
      resetPassword: false,
    ));
    NbUtils.showNav;
  }
}

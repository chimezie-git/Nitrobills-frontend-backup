import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class EmailVerificationSentDialog extends StatelessWidget {
  const EmailVerificationSentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 230.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 42.r,
                left: 25.w,
                right: 25.r,
                bottom: 0,
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: NbColors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      49.verticalSpace,
                      NbText.sp20("Email Verification Sent").w600.black,
                      const Spacer(),
                      NbText.sp14(
                              "We have sent an email verification to saxxxx89@gmail.com."
                              " Please click link on te email to continue")
                          .w500
                          .setColor(const Color(0xFF4D4D4D))
                          .centerText,
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
              Container(
                height: 84.r,
                width: 84.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF65CD8C)),
                child: SvgPicture.asset(
                  NbSvg.mail,
                  width: 33.r,
                  colorFilter:
                      const ColorFilter.mode(NbColors.white, BlendMode.srcIn),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

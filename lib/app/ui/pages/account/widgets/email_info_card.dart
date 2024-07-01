import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class EmailInfoCard extends StatelessWidget {
  final void Function() onTap;
  const EmailInfoCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 233.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 40.r,
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
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: GetX<AuthController>(
                init: Get.find<AuthController>(),
                builder: (cntrl) {
                  return Column(
                    children: [
                      const Spacer(flex: 5),
                      NbText.sp18(cntrl.email.value).w500.black.centerText,
                      const Spacer(flex: 2),
                      NbText.sp14(
                              "Your email address is ${false ? "" : "not"} verified")
                          .w500
                          .setColor(const Color(0xFF4D4D4D)),
                      const Spacer(flex: 1),
                      Container(
                        width: double.maxFinite,
                        height: 1,
                        color: const Color(0xFFCECECE),
                      ),
                      TextButton(
                        onPressed: onTap,
                        child: NbText.sp16(
                                false ? "Change email adress" : "Verify Email")
                            .w500
                            .setColor(const Color(0xFF0A6E8D)),
                      ),
                      const Spacer(flex: 1),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            height: 66.r,
            width: 66.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFD0119B)),
            child: SvgPicture.asset(
              NbSvg.mail,
              width: 24.r,
              colorFilter:
                  const ColorFilter.mode(NbColors.white, BlendMode.srcIn),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AtoZModal extends StatelessWidget {
  const AtoZModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      color: const Color(0xFFF2F2F2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp18("A - Z").w600.black.centerText,
            23.verticalSpace,
            planListTile("A", "Sort A - Z", () {
              Get.back(result: true);
            }),
            planListTile("Z", "Sort Z - A", () {
              Get.back(result: false);
            }),
          ],
        ),
      ),
    );
  }

  Widget planListTile(
    String thumbnail,
    String text,
    void Function() onTap,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 76.h,
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            color: NbColors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFDBDBDB)),
                ),
                child: NbText.sp18(thumbnail).w600.black,
              ),
              24.horizontalSpace,
              NbText.sp16(text).w500.black,
              const Spacer(),
              RotatedBox(
                  quarterTurns: 3,
                  child: SvgPicture.asset(
                    NbSvg.arrowDown,
                    width: 16.r,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

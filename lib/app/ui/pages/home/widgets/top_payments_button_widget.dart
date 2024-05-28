import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class TopPaymentsButtonWidget extends StatelessWidget {
  final String svg;
  final String title;
  final String subtitle;
  final int maxLines;
  final void Function() onTap;

  const TopPaymentsButtonWidget({
    super.key,
    required this.svg,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 156.w,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 13.h,
        ),
        decoration: BoxDecoration(
            color: NbColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: NbColors.black.withOpacity(0.11),
                blurRadius: 16,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46.r,
              height: 46.r,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                border: Border.all(color: NbColors.primary),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                svg,
                colorFilter:
                    const ColorFilter.mode(NbColors.primary, BlendMode.srcIn),
              ),
            ),
            8.verticalSpace,
            NbText.sp14(title).w500.darkGrey.setMaxLines(1),
            8.verticalSpace,
            NbText.sp12(subtitle)
                .w400
                .setColor(const Color(0xFF929090))
                .darkGrey
                .setMaxLines(maxLines),
          ],
        ),
      ),
    );
  }
}

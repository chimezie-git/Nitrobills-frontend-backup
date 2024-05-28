import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class OrderSelectingWidget extends StatelessWidget {
  final bool active;
  final bool aToZ;
  final void Function(bool) onChange;

  const OrderSelectingWidget({
    super.key,
    required this.aToZ,
    required this.active,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!aToZ);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? NbColors.white : const Color(0xFFDCDCDC),
          border: active ? Border.all(color: const Color(0xFF0A6E8D)) : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            NbText.sp16(aToZ ? "A - Z" : "Z - A").w500.setColor(
                  active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
                ),
            8.horizontalSpace,
            SvgPicture.asset(
              NbSvg.arrowDown,
              width: 14.r,
              colorFilter: ColorFilter.mode(
                  active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
                  BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

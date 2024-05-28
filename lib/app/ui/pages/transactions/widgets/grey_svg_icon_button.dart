import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class GreySvgIconButton extends StatelessWidget {
  final String svg;
  final String text;
  final double? iconSize;
  final void Function() onTap;
  const GreySvgIconButton({
    super.key,
    required this.svg,
    required this.text,
    this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 67.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.r,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: NbColors.black,
                ),
              ),
            ),
            SizedBox(
              width: iconSize ?? 24.r,
              height: iconSize ?? 24.r,
              child: SvgPicture.asset(
                svg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

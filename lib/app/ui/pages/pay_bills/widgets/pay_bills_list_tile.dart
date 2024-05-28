import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PayBillsListTile extends StatelessWidget {
  final String image;
  final String text;
  final void Function() onTap;
  const PayBillsListTile({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 76.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: NbColors.white,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFDBDBDB),
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                  ),
                ),
              ),
            ),
            24.horizontalSpace,
            NbText.sp16(text).w500.black,
            const Spacer(),
            RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(NbSvg.arrowDown, width: 16.r),
            ),
          ],
        ),
      ),
    );
  }
}

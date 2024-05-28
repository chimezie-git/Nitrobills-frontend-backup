import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MyBillsCard extends StatelessWidget {
  final String billsDue;
  const MyBillsCard({
    super.key,
    required this.billsDue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 179.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xFF0A6E8D),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 10.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NbText.sp26("My bills").w600.white,
                  const Spacer(flex: 3),
                  NbText.sp16("Total bills due")
                      .w500
                      .setColor(const Color(0xFFE7E7E7)),
                  const Spacer(flex: 1),
                  NbText.sp20("N $billsDue")
                      .w600
                      .setColor(const Color(0xFFE7E7E7)),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(1, 0.2),
            child: Container(
              height: 41.h,
              width: 74.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: NbColors.white,
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(24.r)),
              ),
              child: SvgPicture.asset(
                NbSvg.card,
                colorFilter:
                    const ColorFilter.mode(NbColors.primary, BlendMode.srcIn),
              ),
            ),
          )
        ],
      ),
    );
  }
}

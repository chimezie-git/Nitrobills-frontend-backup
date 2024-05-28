import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AccountTitleWidget extends StatelessWidget {
  final String amount;
  final void Function() refresh;
  const AccountTitleWidget({
    super.key,
    required this.amount,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          NbText.sp18("Account Balance").w600.setColor(const Color(0xFF6B6969)),
          const Spacer(flex: 2),
          NbText.sp20(amount).w500.setColor(const Color(0xFF244047)),
          const Spacer(),
          InkWell(
            onTap: refresh,
            child: SizedBox(
              height: 24.r,
              width: 24.r,
              child: Center(
                child: SvgPicture.asset(
                  NbSvg.refresh,
                  width: 18.r,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

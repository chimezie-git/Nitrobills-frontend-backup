import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ReferralCountField extends StatelessWidget {
  final int count;
  const ReferralCountField({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48.r),
        color: NbColors.white,
        border: Border.all(color: const Color(0xFFCDCDCD)),
      ),
      child: Row(
        children: [
          26.horizontalSpace,
          NbText.sp18("Friends Invited").w500.black,
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48.r),
              color: const Color(0xFF5837F3),
            ),
            child: NbText.sp18("$count").w500.white,
          )
        ],
      ),
    );
  }
}

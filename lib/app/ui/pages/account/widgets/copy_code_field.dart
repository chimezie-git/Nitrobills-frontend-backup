import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class CopyCodeField extends StatelessWidget {
  final String referralCode;
  const CopyCodeField({
    super.key,
    required this.referralCode,
  });

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
          NbText.sp18(_referralDisplay).w500.black,
          const Spacer(),
          InkWell(
            onTap: _copyCode,
            child: Container(
              height: 46.h,
              width: 99.w,
              margin: EdgeInsets.only(right: 5.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48.r),
                color: NbColors.primary,
              ),
              child: NbText.sp16("Copy").w500.white,
            ),
          )
        ],
      ),
    );
  }

  String get _referralDisplay {
    return "${referralCode.substring(0, 3)} ${referralCode.substring(3)}";
  }

  void _copyCode() {
    NbUtils.copyClipBoard(referralCode, "Referral code copied");
  }
}

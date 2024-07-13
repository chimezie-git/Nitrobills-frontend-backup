import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class InstantTransactionTile extends StatelessWidget {
  const InstantTransactionTile({
    super.key,
    required this.bill,
  });

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: bill.saveBeneficiary ? 107.h : 62.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 62.h,
            child: Container(
              padding: EdgeInsets.only(left: 16.w, top: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: const Color(0xFFFFF1CD),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    NbSvg.sparkRounded,
                    width: 19.r,
                    height: 19.r,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFC7841B),
                      BlendMode.srcIn,
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: NbText.sp13("Instant transaction")
                        .w500
                        .setColor(const Color(0xFFC7841B)),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: 62.h,
            child: Container(
              padding: EdgeInsets.only(left: 14.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: NbColors.white,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    NbSvg.beneficiaryHeart,
                    width: 22.r,
                    height: 22.r,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF737373),
                      BlendMode.srcIn,
                    ),
                  ),
                  5.horizontalSpace,
                  Expanded(
                    child: NbText.sp13(
                            "This infomation will be saved as a beneficiary")
                        .w500
                        .setColor(const Color(0xFF737373)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

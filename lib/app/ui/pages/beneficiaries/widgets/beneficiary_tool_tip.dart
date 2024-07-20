import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BeneficiaryToolTip extends StatelessWidget {
  const BeneficiaryToolTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            NbImage.beneficiaryTooltip,
            width: 220.w,
          ),
          NbText.sp14(
              "You can add a beneficiary now or during a payment by selecting the above check-box."),
        ],
      ),
    );
  }
}

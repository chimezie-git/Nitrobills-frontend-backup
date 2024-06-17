import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/data/models/beneficiary.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class BeneficiariesWidget extends StatelessWidget {
  final void Function() onTap;
  final Beneficiary beneficiary;
  final int index;
  const BeneficiariesWidget({
    super.key,
    required this.onTap,
    required this.beneficiary,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 163.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: const Color(0xFFFAFAFA),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64.r,
                      height: 64.r,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: NbUtils.listColor(index),
                      ),
                      child: NbText.sp22(beneficiary.name[0]).white,
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NbText.sp16(beneficiary.serviceType.name).w600.black,
                          const Spacer(),
                          NbText.sp16(beneficiary.name).w500.black,
                          const Spacer(),
                          NbText.sp14(beneficiary.code).w400.black,
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (beneficiary.lastPayment != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NbText.sp16(
                            "Last payment on ${DateFormat("dd-MM-yyyy").format(beneficiary.lastPayment!)}")
                        .w500
                        .black,
                    NbText.sp18("₦${beneficiary.lastPrice ?? 0}").w600.black,
                  ],
                )
              else
                NbText.sp16("No payment made")
                    .w500
                    .setColor(const Color(0xFF8F8F8F)),
            ],
          ),
        ),
      ),
    );
  }
}

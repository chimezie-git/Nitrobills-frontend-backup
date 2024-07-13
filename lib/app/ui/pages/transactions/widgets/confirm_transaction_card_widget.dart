import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ConfirmTransactionCardWidget extends StatelessWidget {
  final Bill bill;

  const ConfirmTransactionCardWidget({
    super.key,
    required this.bill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 26.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: NbColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NbText.sp16("Transaction Information").w500.black,
          infoTile("Service", bill.serviceType.name),
          infoTile("Time", "Jun 26, 2023 • 11:49 PM"),
          // if (bill.serviceType == ServiceTypesEnum.betting ||
          //     bill.serviceType == ServiceTypesEnum.cable)
          //   infoTile("Code", bill.code),
        ],
      ),
    );
  }

  Padding infoTile(String title, String info) {
    return Padding(
      padding: EdgeInsets.only(top: 23.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NbText.sp16(title).w500.black,
          NbText.sp16(info).w500.black,
        ],
      ),
    );
  }
}

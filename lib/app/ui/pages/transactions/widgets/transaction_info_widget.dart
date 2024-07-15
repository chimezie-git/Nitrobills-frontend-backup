import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class TransactionInfoWidget extends StatelessWidget {
  final ExpandableController expandCntr;
  final Bill bill;

  const TransactionInfoWidget({
    super.key,
    required this.expandCntr,
    required this.bill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        color: NbColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ExpandablePanel(
        controller: expandCntr,
        theme: const ExpandableThemeData(hasIcon: false),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: NbText.sp16("Transaction Information")
                      .w700
                      .setColor(const Color(0xFF737373)),
                ),
                RotatedBox(
                  quarterTurns: expandCntr.expanded ? 0 : 2,
                  child: SvgPicture.asset(
                    NbSvg.arrowDown,
                    width: 15.w,
                    colorFilter: const ColorFilter.mode(
                      NbColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Container(
              width: double.maxFinite,
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xFFF1F1F1),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    NbSvg.autopay,
                    width: 18.r,
                    height: 18.r,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF737373),
                      BlendMode.srcIn,
                    ),
                  ),
                  16.horizontalSpace,
                  NbText.sp13("Automated payment").w500.setColor(
                        const Color(0xFF737373),
                      ),
                ],
              ),
            ),
            24.verticalSpace,
            _listTile(NbSvg.sparkOutline, "Service", bill.serviceType.name),
          ],
        ),
        collapsed: Column(
          children: [
            24.verticalSpace,
            _listTile(NbSvg.charge, "Charge", "NGN 10.0"),
            30.verticalSpace,
            _listTile(NbSvg.naira, "Amount", "NGN ${bill.amount}"),
            30.verticalSpace,
            _listTile(
              NbSvg.dateTime,
              "Date & Time",
              DateFormat("d MMM yyyy, hh:mm a").format(
                DateTime.now(),
              ),
            ),
            30.verticalSpace,
            _listTile(NbSvg.validity, "Validity", bill.serviceType.name),
          ],
        ),
        expanded: const SizedBox.shrink(),
      ),
    );
  }

  SizedBox _listTile(String svg, String title, String info) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xFFF1F1F1),
            ),
            child: SvgPicture.asset(
              svg,
              width: 16.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF737373),
                BlendMode.srcIn,
              ),
            ),
          ),
          16.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NbText.sp16(title)
                  .w400
                  .setColor(const Color(0xFF737373))
                  .setLinesHeight(1.0),
              NbText.sp18(info).w700.black.setLinesHeight(1.0),
            ],
          )
        ],
      ),
    );
  }
}

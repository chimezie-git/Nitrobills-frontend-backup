import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';

import 'package:nitrobills/app/data/services/formatter.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
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
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: NbColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NbText.sp16("Order Details").w500.black,
          24.verticalSpace,
          infoTile(NbSvg.naira, "Amount",
              "NGN ${NbFormatter.amount(bill.amount, 2)}"),
          24.verticalSpace,
          infoTile(
            ((bill.serviceType == ServiceTypesEnum.airtime) ||
                    (bill.serviceType == ServiceTypesEnum.data))
                ? NbSvg.phone
                : NbSvg.senderName,
            _recepientTitle(),
            (bill.serviceType == ServiceTypesEnum.bulkSms)
                ? bill.name
                : bill.codeNumber,
          ),
          24.verticalSpace,
          infoTile(
              NbSvg.trophy,
              (bill.serviceType == ServiceTypesEnum.bulkSms)
                  ? "Amount"
                  : "Provider",
              bill.provider.name),
        ],
      ),
    );
  }

  Widget infoTile(String svg, String title, String info) {
    return SizedBox(
      height: 50.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: SvgPicture.asset(
              svg,
              colorFilter:
                  const ColorFilter.mode(NbColors.darkGrey, BlendMode.srcIn),
            ),
          ),
          4.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NbText.sp16(title).w400.black.setLinesHeight(1),
                NbText.sp18(info).w700.black.setLinesHeight(1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _recepientTitle() {
    switch (bill.serviceType) {
      case ServiceTypesEnum.airtime:
      case ServiceTypesEnum.data:
        return "Phone number";
      case ServiceTypesEnum.cable:
        return "Smart card number";
      case ServiceTypesEnum.betting:
        return "Bet ID";
      case ServiceTypesEnum.electricity:
        return "Meter number";
      case ServiceTypesEnum.bulkSms:
        return "Sender name";
    }
  }
}

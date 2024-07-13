import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class TransactionPaymentPreferenceWidget extends StatelessWidget {
  const TransactionPaymentPreferenceWidget({
    super.key,
    required this.bill,
    required this.autopayment,
    required this.dataManagement,
    required this.onSetAutopayment,
    required this.onSetDataManagement,
  });

  final Bill bill;
  final bool autopayment;
  final bool dataManagement;
  final void Function(bool) onSetAutopayment;
  final void Function(bool) onSetDataManagement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: NbColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                NbSvg.preference,
                width: 18.r,
                height: 18.r,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF707070),
                  BlendMode.srcIn,
                ),
              ),
              10.horizontalSpace,
              NbText.sp16("Payment Preferences").w700.setColor(
                    const Color(0xFF707070),
                  )
            ],
          ),
          18.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                NbSvg.stopWatch,
                width: 18.w,
                height: 18.h,
                colorFilter: const ColorFilter.mode(
                  NbColors.black,
                  BlendMode.srcIn,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: NbText.sp14("Make this an automatic payment").w500.black,
              ),
              NbField.check(
                value: autopayment,
                onChanged: onSetAutopayment,
                size: 24.r,
                radius: 6.r,
                border: 2.r,
                bgColor: 0xFF000000,
              ),
            ],
          ),
          if (bill.serviceType == ServiceTypesEnum.data) ...[
            18.verticalSpace,
            Row(
              children: [
                24.horizontalSpace,
                Expanded(
                  child: NbText.sp14("Enable data mangement").w500.black,
                ),
                NbField.check(
                  value: dataManagement,
                  onChanged: onSetDataManagement,
                  size: 24.r,
                  radius: 6.r,
                  border: 2.r,
                  bgColor: 0xFF000000,
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/confirm_transaction_card_widget.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/contact_support_card.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/rate_exprerience_card.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Bill bill;

  const TransactionDetailsScreen({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Column(
                      children: [
                        70.verticalSpace,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 32.r,
                              width: 32.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(bill.provider.image),
                                ),
                              ),
                            ),
                            8.horizontalSpace,
                            NbText.sp18(_planOrAmount()).w700.black,
                          ],
                        ),
                        16.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 28.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            color: const Color(0xFFC2E8D2),
                          ),
                          child: NbText.sp18("Successful")
                              .w400
                              .setColor(const Color(0xFF2E7E45)),
                        ),
                        84.verticalSpace,
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: NbColors.white,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                    text:
                                        "Thanks for using nitro. Your order to "),
                                TextSpan(
                                    text: _recepientName(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    )),
                                const TextSpan(
                                    text:
                                        " is successful your voucher / information has been sent to your number."),
                              ],
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: NbColors.black,
                              ),
                            ),
                          ),
                        ),
                        27.verticalSpace,
                        ConfirmTransactionCardWidget(
                          bill: bill,
                        ),
                        20.verticalSpace,
                        const RateExprerienceCard(),
                        20.verticalSpace,
                        const ContactSupportCard(),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 113,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: NbColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 154.w,
                      child: NbButton.outlinedPrimary(
                          text: "Share Receipt", onTap: _shareReceipt)),
                  SizedBox(
                    width: 154.w,
                    child: BlackWidgetButton(
                      onTap: _continue,
                      status: ButtonEnum.active,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NbText.sp14("Return Home").w500.white,
                          8.horizontalSpace,
                          SvgPicture.asset(
                            NbSvg.home,
                            width: 18.r,
                            colorFilter: const ColorFilter.mode(
                                NbColors.white, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continue() {
    Navigator.popUntil(Get.context!, (route) => route.isFirst);
  }

  void _shareReceipt() {}

  String _planOrAmount() {
    if (bill.serviceType == ServiceTypesEnum.data) {
      final dBill = bill as DataBill;
      return dBill.plan.name;
    } else if (bill.serviceType == ServiceTypesEnum.cable) {
      final cBill = bill as CableBill;
      return cBill.plan.name;
    } else {
      return "₦ ${bill.amount}";
    }
  }

  String _recepientName() {
    if (bill.saveBeneficiary) {
      return bill.name;
    } else {
      return bill.codeNumber;
    }
  }
}

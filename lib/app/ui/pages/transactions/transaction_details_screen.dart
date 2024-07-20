import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/return_home_button.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/small_outline_button.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/confirm_transaction_card_widget.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/contact_support_card.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/rate_exprerience_card.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/success_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Bill bill;

  const TransactionDetailsScreen({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
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
                        SuccessWidget(bill: bill),
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
                  SmallOutlineButton(
                    onTap: _shareReceipt,
                    text: "Share receipt",
                  ),
                  ReturnHomeButton(
                    status: ButtonEnum.active,
                    onTap: () => _continue(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continue(BuildContext context) {
    Get.find<UserAccountController>().reload();
    Navigator.popUntil(Get.context!, (route) => route.isFirst);
  }

  void _shareReceipt() {}

  String _recepientName() {
    if (bill.saveBeneficiary) {
      return bill.name;
    } else {
      return bill.codeNumber;
    }
  }
}

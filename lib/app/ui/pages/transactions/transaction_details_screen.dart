import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/confirm_transaction_card_widget.dart';
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
        body: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  36.verticalSpace,
                  NbText.sp18("Transaction Details").w600.black,
                  63.verticalSpace,
                  NbText.sp16("₦  ${bill.amount.round()}").w500.black,
                  28.verticalSpace,
                  Container(
                    width: double.maxFinite,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5BF0C3),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: NbText.sp16("Transaction Successful").w500.black,
                  ),
                  27.verticalSpace,
                  ConfirmTransactionCardWidget(
                    bill: bill,
                  ),
                  20.verticalSpace,
                  NbButton.outlinedPrimary(text: "Continue", onTap: _continue),
                  20.verticalSpace,
                  NbButton.primary(text: "Share Receipt", onTap: _shareReceipt),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _continue() {
    Navigator.popUntil(Get.context!, (route) => route.isFirst);
  }

  void _shareReceipt() {}
}

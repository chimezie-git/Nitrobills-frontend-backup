import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/transactions/transaction_details_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/confirm_transaction_card_widget.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/make_recurring_payment_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ConfirmTransactionScreen extends StatefulWidget {
  final Transaction transaction;

  const ConfirmTransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<ConfirmTransactionScreen> createState() =>
      _ConfirmTransactionScreenState();
}

class _ConfirmTransactionScreenState extends State<ConfirmTransactionScreen> {
  bool makeAutopay = false;
  bool enableDataManagement = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                NbHeader.backAndTitle(
                  "Confirm Transaction",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                21.verticalSpace,
                SvgPicture.asset(
                  NbSvg.transactionsTitle,
                  width: 98.w,
                  height: 60.h,
                ),
                30.verticalSpace,
                NbText.sp20("N${widget.transaction.price.round()}").w600.black,
                20.verticalSpace,
                ConfirmTransactionCardWidget(
                  transaction: widget.transaction,
                ),
                31.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: NbText.sp16("Make this a recurring payment")
                          .w500
                          .black,
                    ),
                    NbField.check(
                      value: makeAutopay,
                      onChanged: (v) {
                        _makeRecurringPayment(v);
                      },
                    ),
                  ],
                ),
                if (widget.transaction.serviceTypes ==
                    ServiceTypesEnum.data) ...[
                  31.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: NbText.sp16("Enable Data mangement for this SIM")
                            .w500
                            .black,
                      ),
                      NbField.check(
                        value: enableDataManagement,
                        onChanged: (v) {
                          setState(() {
                            enableDataManagement = v;
                          });
                        },
                      ),
                    ],
                  )
                ],
                28.verticalSpace,
                NbButton.primary(text: "Continue", onTap: _continue)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _makeRecurringPayment(bool value) async {
    if (value) {
      bool? hasSetData = await Get.bottomSheet<bool>(
        const MakeRecurringPaymentModal(),
        backgroundColor: Colors.black.withOpacity(0.2),
        isScrollControlled: true,
      );

      if (hasSetData ?? false) {
        setState(() {
          makeAutopay = value;
        });
      }
    } else {
      setState(() {
        makeAutopay = value;
      });
    }
  }

  void _continue() {
    Get.to(() => TransactionDetailsScreen(transaction: widget.transaction));
  }
}

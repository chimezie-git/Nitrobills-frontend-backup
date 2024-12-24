// ignore_for_file: use_build_context_synchronously

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/autopay_controller.dart';
import 'package:nitrobills/app/controllers/account/transactions_controller.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/bills/airtime_controller.dart';
import 'package:nitrobills/app/controllers/bills/betting_controller.dart';
import 'package:nitrobills/app/controllers/bills/cable_controller.dart';
import 'package:nitrobills/app/controllers/bills/data_controller.dart';
import 'package:nitrobills/app/controllers/bills/electricity_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/models/pay_frequency.dart';
import 'package:nitrobills/app/data/services/bills/bulk_sms_service.dart';
import 'package:nitrobills/app/data/services/formatter.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/pay_now_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/autopayments/models/autopay.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/transaction_details_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/confirm_details_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/instant_transaction_tile.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/make_recurring_payment_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/overview_provider_tile.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/pin_code_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/transaction_info_widget.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/transaction_payment_preference_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class ConfirmTransactionScreen extends StatefulWidget {
  final Bill bill;

  const ConfirmTransactionScreen({
    super.key,
    required this.bill,
  });

  @override
  State<ConfirmTransactionScreen> createState() =>
      _ConfirmTransactionScreenState();
}

class _ConfirmTransactionScreenState extends State<ConfirmTransactionScreen> {
  bool makeAutopay = false;
  bool enableDataManagement = false;

  ButtonEnum btnStatus = ButtonEnum.disabled;
  late ExpandableController expandCntr;

  int? avatarColor;
  int? avatarIdx;

  PayFrequency? payFrequency;
  DateTime? autopayEndDate;

  @override
  void initState() {
    super.initState();
    expandCntr = ExpandableController(initialExpanded: true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        btnStatus = ButtonEnum.active;
      });
    });
  }

  @override
  void dispose() {
    expandCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            36.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: NbHeader.backAndTitle(
                "Transaction overview",
                () {
                  Get.back();
                },
                fontSize: 18.w,
                fontWeight: FontWeight.w600,
                color: NbColors.black,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Column(
                    children: [
                      21.verticalSpace,
                      OverviewProviderTile(
                        bill: widget.bill,
                        colorIdx: avatarColor,
                        avatarIdx: avatarIdx,
                        onSetAvatar: (col, idx) {
                          setState(() {
                            avatarColor = col;
                            avatarIdx = idx;
                          });
                        },
                      ),
                      6.verticalSpace,
                      Row(
                        children: [
                          16.horizontalSpace,
                          NbText.sp13("Available balance")
                              .w500
                              .setColor(const Color(0xFF7F7F7F)),
                          8.horizontalSpace,
                          GetBuilder<UserAccountController>(builder: (cntrl) {
                            return NbText.sp13(
                                    "NGN ${NbFormatter.amount(cntrl.totalAmount, 2)}")
                                .w500
                                .black;
                          }),
                        ],
                      ),
                      15.verticalSpace,
                      InstantTransactionTile(bill: widget.bill),
                      15.verticalSpace,
                      TransactionPaymentPreferenceWidget(
                        bill: widget.bill,
                        autopayment: makeAutopay,
                        dataManagement: enableDataManagement,
                        onSetAutopayment: (v) {
                          _makeRecurringPayment(v);
                        },
                        onSetDataManagement: (v) {
                          _setDataManagement(v);
                        },
                      ),
                      15.verticalSpace,
                      // if (makeAutopay)
                      TransactionInfoWidget(
                        bill: widget.bill,
                        expandCntr: expandCntr,
                        endDate: autopayEndDate,
                      ),
                      20.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 113.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 19.5.w,
                vertical: 28.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.r),
                ),
                color: NbColors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NbText.sp16("Amount")
                            .w400
                            .setColor(const Color(0xFF737373))
                            .setLinesHeight(1.0),
                        NbText.sp18("NGN ${widget.bill.amount}")
                            .w700
                            .black
                            .setLinesHeight(1.0),
                      ],
                    ),
                  ),
                  PayNowButton(
                    status: btnStatus,
                    onTap: _payNow,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _makeRecurringPayment(bool value) async {
    if (value) {
      // (PayFrequency, DateTime)
      final hasSetData = await Get.bottomSheet<(PayFrequency, DateTime)?>(
        isDismissible: true,
        MakeRecurringPaymentModal(
          serviceType: widget.bill.serviceType,
          amount: NbFormatter.amount(widget.bill.amount),
          frequency: payFrequency,
          endDate: autopayEndDate,
        ),
        backgroundColor: Colors.black.withOpacity(0.2),
        isScrollControlled: true,
      );

      if (hasSetData != null) {
        if (expandCntr.expanded) {
          expandCntr.toggle();
        }
        setState(() {
          payFrequency = hasSetData.$1;
          autopayEndDate = hasSetData.$2;
          makeAutopay = true;
        });
      }
    } else {
      if (!expandCntr.expanded) {
        expandCntr.toggle();
      }
      setState(() {
        payFrequency = null;
        autopayEndDate = null;
        makeAutopay = false;
      });
    }
  }

  Future _setDataManagement(bool value) async {}

  void _payNow() async {
    final confirmed = await Get.bottomSheet<(bool, int?)?>(
      isDismissible: true,
      ConfirmDetailsModal(
        bill: widget.bill,
        avatarColor: avatarColor,
        avatarIdx: avatarIdx,
      ),
      isScrollControlled: true,
    );
    if (confirmed?.$1 ?? false) {
      //

      final verified = await Get.bottomSheet<bool?>(
        isDismissible: true,
        const PinCodeModal(),
        isScrollControlled: true,
      );
      if (verified ?? false) {
        // make payment
        setState(() {
          btnStatus = ButtonEnum.loading;
        });
        widget.bill.update(benId: confirmed?.$2);
        bool success = await pay();
        btnStatus = ButtonEnum.active;
        setState(() {});
        if (success) {
          await Future.delayed(const Duration(milliseconds: 500));
          Get.to(() => TransactionDetailsScreen(bill: widget.bill));
        } else {
          NbToast.show(context, "Transaction failed");
        }
      } else {
        return;
      }
    } else {
      return;
    }
  }

  Future<bool> pay() async {
    if (makeAutopay && (widget.bill.autopayId == null)) {
      Autopay autopay = Autopay.createNew(
        payFrequency!,
        autopayEndDate!,
        widget.bill,
      );
      Autopay? aPay =
          await Get.find<AutopayController>().create(context, autopay);

      if (aPay != null) {
        widget.bill.update(autoId: aPay.id);
      }
    }

    bool success;
    if (widget.bill is AirtimeBill) {
      success = await Get.find<AirtimeController>()
          .buy(context, widget.bill as AirtimeBill);
    } else if (widget.bill is DataBill) {
      success = await Get.find<DataController>()
          .buy(context, widget.bill as DataBill);
    } else if (widget.bill is BetBill) {
      success = await Get.find<BettingController>()
          .buy(context, widget.bill as BetBill);
    } else if (widget.bill is ElectricityBill) {
      success = await Get.find<ElectricityController>()
          .buy(context, widget.bill as ElectricityBill);
    } else if (widget.bill is CableBill) {
      success = await Get.find<CableController>()
          .buy(context, widget.bill as CableBill);
    } else if (widget.bill is BulkSMSBill) {
      final tran = await BulkSmsService.buy(widget.bill as BulkSMSBill);
      if (tran.isRight) {
        Get.find<TransactionsController>().addTransaction(tran.right);
        success = true;
      } else {
        NbToast.error(context, tran.left.message);
        success = false;
      }
    } else {
      throw Exception("Nitrobills error: not a valid bill type");
    }
    return success;
  }
}

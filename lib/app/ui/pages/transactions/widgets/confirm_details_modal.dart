import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/services/formatter.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/proceed_button.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/small_outline_button.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ConfirmDetailsModal extends StatefulWidget {
  final Bill bill;
  final int? avatarColor;
  final int? avatarIdx;
  const ConfirmDetailsModal(
      {super.key,
      required this.bill,
      required this.avatarColor,
      required this.avatarIdx});

  @override
  State<ConfirmDetailsModal> createState() => _ConfirmDetailsModalState();
}

class _ConfirmDetailsModalState extends State<ConfirmDetailsModal> {
  ButtonEnum status = ButtonEnum.active;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      color: NbColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            34.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: NbText.sp18("Confirm your details").w700.black,
            ),
            16.verticalSpace,
            _infoTile(
                "Amount", "NGN ${NbFormatter.amount(widget.bill.amount)}"),
            24.verticalSpace,
            _planWidget(),
            _infoTile("Number/ID", widget.bill.codeNumber),
            24.verticalSpace,
            _infoTile("Provider", widget.bill.provider.name.toUpperCase()),
            24.verticalSpace,
            _infoTile("Charge", "NGN 10.0"),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallOutlineButton(onTap: () => Get.back(), text: "Cancel"),
                ProceedButton(status: status, onTap: _proceed),
              ],
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Column _infoTile(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NbText.sp16(title).w400.setColor(const Color(0xFF737373)),
        10.verticalSpace,
        NbText.sp18(info).w700.setColor(const Color(0xFF212121)).setMaxLines(1),
      ],
    );
  }

  Widget _planWidget() {
    if (widget.bill is DataBill) {
      final dbill = widget.bill as DataBill;
      return Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: _infoTile("Plan", dbill.plan.name),
      );
    } else if (widget.bill is CableBill) {
      final cBill = widget.bill as CableBill;
      return Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: _infoTile("Plan", cBill.plan.name),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future _proceed() async {
    int? benId;
    if (widget.bill.saveBeneficiary && (widget.bill.beneficiaryId == null)) {
      setState(() {
        status = ButtonEnum.loading;
      });
      benId = await Get.find<BeneficiariesController>().create(
        context,
        name: widget.bill.name,
        number: widget.bill.codeNumber,
        serviceType: widget.bill.serviceType,
        provider: widget.bill.provider,
        colorId: widget.avatarColor ?? 0,
        avatarId: widget.avatarIdx ?? 0,
      );
      setState(() {
        status = ButtonEnum.active;
      });
    }
    Get.back(result: (true, benId));
  }
}

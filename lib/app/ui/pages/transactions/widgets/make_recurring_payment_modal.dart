import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/pay_frequency.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/big_primary_button.dart';
import 'package:nitrobills/app/ui/global_widgets/custom_date_picker_dialog.dart';
import 'package:nitrobills/app/ui/global_widgets/frequency_selection_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/grey_svg_icon_button.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MakeRecurringPaymentModal extends StatefulWidget {
  final ServiceTypesEnum serviceType;
  final String amount;
  final PayFrequency? frequency;
  final DateTime? endDate;

  const MakeRecurringPaymentModal(
      {super.key,
      required this.serviceType,
      required this.amount,
      this.frequency,
      this.endDate});

  @override
  State<MakeRecurringPaymentModal> createState() =>
      _MakeRecurringPaymentModalState();
}

class _MakeRecurringPaymentModalState extends State<MakeRecurringPaymentModal> {
  PayFrequency? frequency;
  DateTime? date;

  late ButtonEnum btnStatus;

  @override
  void initState() {
    super.initState();
    frequency = widget.frequency;
    date = widget.endDate;
    btnStatus = ButtonEnum.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NbColors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 41.h, 25.w, 25.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            infoTile("Subscription", widget.serviceType.shortName),
            34.verticalSpace,
            infoTile("Price", widget.amount),
            21.verticalSpace,
            Row(
              children: [
                NbText.sp14("What does this mean ?").w400.setColor(
                      const Color(0xFF8F8F8F),
                    ),
                8.horizontalSpace,
                ElTooltip(
                  content: NbText.sp14(
                          "How often do you want the transaction to be repeated?")
                      .w400
                      .black,
                  color: const Color(0xFFF2F2F2),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 15.h,
                  ),
                  radius: Radius.circular(16.r),
                  child: Container(
                    width: 16.r,
                    height: 16.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF8F8F8F),
                      ),
                    ),
                    child: SvgPicture.asset(
                      NbSvg.iSvg,
                      height: 6.h,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFF8F8F8F), BlendMode.srcIn),
                    ),
                  ),
                )
              ],
            ),
            GreySvgIconButton(
              svg: NbSvg.arrowDown,
              text: frequency?.period.adjective ?? "Frequency",
              iconSize: 16.r,
              onTap: _frequency,
            ),
            21.verticalSpace,
            GreySvgIconButton(
              svg: NbSvg.calendar,
              text: date == null
                  ? "End date"
                  : DateFormat("dd MMM yyyy").format(date!),
              iconSize: 20.r,
              onTap: _endDate,
            ),
            21.verticalSpace,
            BigPrimaryButton(
              status: btnStatus,
              text: "Save",
              onTap: _save,
            ),
          ],
        ),
      ),
    );
  }

  Row infoTile(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NbText.sp16(title).w500,
        NbText.sp16(info).w600,
      ],
    );
  }

  void _frequency() async {
    frequency = await Get.bottomSheet<PayFrequency>(
          const FrequencySelectionModal(),
          backgroundColor: Colors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        frequency;

    _updateButton();
  }

  void _endDate() async {
    date = await Get.dialog<DateTime>(
          CustomDatePickerDialog(
            currentDate: DateTime.now().add(const Duration(days: 1)),
            lastDate: DateTime.now(),
            selectedDay: date,
          ),
          barrierColor: Colors.black.withOpacity(0.2),
        ) ??
        date;
    _updateButton();
  }

  void _updateButton() {
    if ((date != null) && (frequency != null)) {
      btnStatus = ButtonEnum.active;
    } else {
      btnStatus = ButtonEnum.disabled;
    }
    setState(() {});
  }

  void _save() {
    if (frequency != null && date != null) {
      Get.back(result: (frequency, date));
    } else {
      Get.back();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/data/enums/period_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/custom_date_picker_dialog.dart';
import 'package:nitrobills/app/ui/global_widgets/frequency_selection_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/grey_svg_icon_button.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MakeRecurringPaymentModal extends StatefulWidget {
  const MakeRecurringPaymentModal({super.key});

  @override
  State<MakeRecurringPaymentModal> createState() =>
      _MakeRecurringPaymentModalState();
}

class _MakeRecurringPaymentModalState extends State<MakeRecurringPaymentModal> {
  PeriodEnum? frequency;
  DateTime? date;

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
            infoTile("Subscription", "TvSub"),
            34.verticalSpace,
            infoTile("Price", "N300"),
            21.verticalSpace,
            GreySvgIconButton(
              svg: NbSvg.arrowDown,
              text: frequency?.adjective ?? "Frequency",
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
            NbButton.primary(text: "Save", onTap: _save),
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
    frequency = await Get.bottomSheet<PeriodEnum>(
          const FrequencySelectionModal(),
          backgroundColor: Colors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        frequency;
    setState(() {});
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
    setState(() {});
  }

  void _save() {
    if (frequency != null && date != null) {
      Get.back(result: true);
    } else {
      Get.back();
    }
  }
}

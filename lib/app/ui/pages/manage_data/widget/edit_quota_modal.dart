import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/period_enum.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class EditQuotaModal extends StatefulWidget {
  final String totalData;
  final String usedData;
  final PeriodEnum periodEnum;

  const EditQuotaModal(
      {super.key,
      required this.totalData,
      required this.usedData,
      required this.periodEnum});

  @override
  State<EditQuotaModal> createState() => _EditQuotaModalState();
}

class _EditQuotaModalState extends State<EditQuotaModal> {
  late final TextEditingController totalDataCntr;
  late final TextEditingController usedDataCntr;
  late PeriodEnum period;

  @override
  void initState() {
    super.initState();
    totalDataCntr = TextEditingController();
    usedDataCntr = TextEditingController();
    period = widget.periodEnum;
  }

  @override
  void dispose() {
    totalDataCntr.dispose();
    usedDataCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MobileServiceProvider provider = MobileServiceProvider.mtn;
    return Material(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 25.h, 25.w, 25.h),
        child: ListView(
          shrinkWrap: true,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: NbText.sp20("Edit Quota").w600.black,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: MobileServiceProvider.all.map((e) {
                bool sel = e.id == provider.id;
                return InkWell(
                  onTap: () {
                    provider = e;
                    setState(() {});
                  },
                  child: Container(
                    padding: sel
                        ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h)
                        : EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: sel ? NbColors.black : null,
                    ),
                    child: NbText.sp20(e.name).w500.setColor(
                          sel ? NbColors.white : const Color(0xFF929090),
                        ),
                  ),
                );
              }).toList(),
            ),
            20.verticalSpace,
            Wrap(
              spacing: 46.w,
              runSpacing: 25.h,
              children: [
                _SimNumberTile("MTN 2323", true, () {}),
                _SimNumberTile("MTN 5532", false, () {}),
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LabelledTextField(totalDataCntr, "Plan", "GB"),
                _DropdownLabelField(period, "Per", (p0) {
                  setState(() {
                    period = p0 ?? period;
                  });
                }),
              ],
            ),
            20.verticalSpace,
            Row(
              children: [
                _LabelledTextField(usedDataCntr, "Used", "GB"),
              ],
            ),
            25.verticalSpace,
            NbButton.primary(text: "Save", onTap: _save),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }

  void _save() {}
}

class _DropdownLabelField extends StatelessWidget {
  final PeriodEnum periodEnum;
  final String title;
  final void Function(PeriodEnum?) onChanged;
  const _DropdownLabelField(
    this.periodEnum,
    this.title,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NbText.sp20(title).w500.black,
        16.verticalSpace,
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFA9A9A9)),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: DropdownButton(
            value: periodEnum,
            onChanged: onChanged,
            underline: const SizedBox.shrink(),
            icon: Container(
              width: 51.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(5.r),
                ),
                color: const Color(0xFFECECEC),
              ),
              child: SvgPicture.asset(NbSvg.arrowDown),
            ),
            items: PeriodEnum.all
                .map(
                  (per) => DropdownMenuItem<PeriodEnum>(
                    value: per,
                    child: SizedBox(
                      width: 80.w,
                      child: NbText.sp20(per.name.capitalize ?? "").centerText,
                    ),
                  ),
                )
                .toList(),
          ),
          // child: Row(
          //   children: [
          //     Expanded(
          //       child: DropdownButton(
          //           value: periodEnum,
          //           onChanged: onChanged,
          //           items: PeriodEnum.all
          //               .map((per) => DropdownMenuItem<PeriodEnum>(
          //                   value: per,
          //                   child: NbText.sp20(per.name.capitalize ?? "")))
          //               .toList()),
          //     ),
          //     Container(
          //       width: 51.w,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.horizontal(
          //           right: Radius.circular(5.r),
          //         ),
          //         color: const Color(0xFFECECEC),
          //       ),
          //       child: SvgPicture.asset(NbSvg.arrowDown),
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }
}

class _LabelledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String label;
  const _LabelledTextField(this.controller, this.title, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NbText.sp20(title).w500.black,
        16.verticalSpace,
        Container(
          width: 134.w,
          height: 52.h,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFA9A9A9)),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: NbColors.black,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: NbColors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.r,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: 51.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(5.r),
                  ),
                  color: const Color(0xFFECECEC),
                ),
                child: NbText.sp20("GB").w500.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimNumberTile extends StatelessWidget {
  final String txt;
  final bool selected;
  final void Function() onTap;

  const _SimNumberTile(this.txt, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: selected ? const Color(0xFFFDBBBB) : const Color(0xFFD0CFCF),
      ),
      child: NbText.sp20("MTN 3284").w500.setColor(
          selected ? const Color(0xFF932626) : const Color(0xFF252424)),
    );
  }
}

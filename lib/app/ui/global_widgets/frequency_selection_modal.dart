import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/pay_frequency.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class FrequencySelectionModal extends StatelessWidget {
  const FrequencySelectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    List<PayFrequency> periodList = PayFrequency.all;
    return Material(
      color: NbColors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 41.h, 25.w, 25.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NbText.sp16("Frequency").w500.black,
                18.horizontalSpace,
                Image.asset(
                  NbImage.flag,
                  width: 24.w,
                  height: 21.h,
                ),
              ],
            ),
            19.verticalSpace,
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    _frequencyTile(periodList[index]),
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    color: const Color(0xFFBBB9B9),
                  );
                },
                itemCount: periodList.length),
          ],
        ),
      ),
    );
  }

  Widget _frequencyTile(PayFrequency payFreq) {
    bool isCustom = (payFreq is CustomFrequency);
    return InkWell(
      onTap: () {
        Get.back(result: payFreq);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF2BBBAD)),
                      borderRadius: BorderRadius.circular(14.r)),
                  child: NbText.sp16(payFreq.period.adjective)
                      .w500
                      .setColor(const Color(0xFF282828)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: isCustom
                  ? Row(
                      children: [
                        NbText.sp16("Every")
                            .w500
                            .setColor(const Color(0xFF454040)),
                        8.horizontalSpace,
                        _TextFieldBox(days: payFreq.days!),
                        8.horizontalSpace,
                        NbText.sp16("Day(s)")
                            .w500
                            .setColor(const Color(0xFF454040))
                      ],
                    )
                  : NbText.sp16("Every ${payFreq.period.name}").w500.setColor(
                        const Color(0xFF454040),
                      ),
            )
          ],
        ),
      ),
    );
  }
}

class _TextFieldBox extends StatefulWidget {
  final int days;
  const _TextFieldBox({
    required this.days,
  });

  @override
  State<_TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<_TextFieldBox> {
  late TextEditingController _cntrl;

  @override
  void initState() {
    super.initState();
    _cntrl = TextEditingController(text: "${widget.days}");
  }

  @override
  void dispose() {
    _cntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38.w,
      height: 34.h,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: NbColors.black),
      ),
      child: TextField(
        controller: _cntrl,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          height: 1,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

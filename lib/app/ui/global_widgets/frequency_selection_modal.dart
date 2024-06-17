import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/period_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class FrequencySelectionModal extends StatelessWidget {
  const FrequencySelectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    List<PeriodEnum> periodList = PeriodEnum.values.toList();
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

  Widget _frequencyTile(PeriodEnum period) {
    return InkWell(
      onTap: () {
        Get.back(result: period);
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
                  child: NbText.sp16(period.adjective)
                      .w500
                      .setColor(const Color(0xFF282828)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: NbText.sp16("Every ${period.name}").w500.setColor(
                    const Color(0xFF454040),
                  ),
            )
          ],
        ),
      ),
    );
  }
}

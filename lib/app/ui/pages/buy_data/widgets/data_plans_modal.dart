import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/data_plan.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class DataPlansModal extends StatelessWidget {
  final List<DataPlan> dataPlans;
  const DataPlansModal({super.key, required this.dataPlans});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      color: NbColors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 19.h, 24.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NbText.sp16("Data Plans").w500.black.centerText,
                5.horizontalSpace,
                Image.asset(
                  NbImage.flag,
                  width: 24.r,
                ),
              ],
            ),
            20.verticalSpace,
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 500.h),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataPlans.length,
                itemBuilder: (context, index) {
                  DataPlan plan = dataPlans[index];
                  return planListTile(
                    plan.provider.image,
                    plan.name,
                    plan.priceString,
                    () {
                      _select(plan);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget planListTile(
      String image, String title, String subtitle, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 40.r,
              height: 40.r,
            ),
            13.horizontalSpace,
            NbText.sp16(title).w500.black,
            const Spacer(),
            NbText.sp16(subtitle).w600.setColor(const Color(0xFF0A6E8D)),
          ],
        ),
      ),
    );
  }

  void _select(DataPlan plan) async {
    Get.back(result: plan);
  }
}

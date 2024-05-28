import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/cable_plan.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class CablePlansModal extends StatelessWidget {
  final List<CablePlan> cablePlans;
  const CablePlansModal({super.key, required this.cablePlans});

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
                NbText.sp16("Packages").w500.black.centerText,
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
                itemCount: cablePlans.length,
                itemBuilder: (context, index) {
                  CablePlan plan = cablePlans[index];
                  return planListTile(
                    plan.provider.image,
                    plan.name,
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

  Widget planListTile(String image, String title, void Function() onTap) {
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
          ],
        ),
      ),
    );
  }

  void _select(CablePlan plan) async {
    Get.back(result: plan);
  }
}

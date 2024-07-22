import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/bills/data_controller.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/services/formatter.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class GbDataPlansModal extends StatelessWidget {
  final MobileServiceProvider provider;
  const GbDataPlansModal({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      color: NbColors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 19.h, 24.w, 0),
        child: GetBuilder<DataController>(
          init: Get.find<DataController>(),
          initState: (_) {
            Get.find<DataController>().initializePlans(context, provider.id);
          },
          builder: (cntrl) {
            List<GbDataPlans> dataPlans = cntrl.getDataPlans(provider.id);
            if (cntrl.status.value.isLoading) {
              return SizedBox(
                height: 200.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: NbColors.black,
                  ),
                ),
              );
            }
            return Column(
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
                      GbDataPlans plan = dataPlans[index];
                      return planListTile(
                        provider.image,
                        plan.name,
                        NbFormatter.amount(plan.amount),
                        () {
                          _select(plan);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget planListTile(
      String image, String name, String amount, void Function() onTap) {
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
            Expanded(child: NbText.sp16(name).w500.black),
            13.horizontalSpace,
            NbText.sp16("₦$amount").w600.setColor(const Color(0xFF0A6E8D)),
          ],
        ),
      ),
    );
  }

  void _select(GbDataPlans plan) async {
    Get.back(result: plan);
  }
}

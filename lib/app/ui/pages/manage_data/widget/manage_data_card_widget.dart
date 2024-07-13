import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/manage_data_controller.dart';
import 'package:nitrobills/app/data/enums/period_enum.dart';
import 'package:nitrobills/app/hive_box/data_management/data_management.dart';
import 'package:nitrobills/app/ui/pages/manage_data/widget/edit_quota_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class ManageDataCardWidget extends StatelessWidget {
  const ManageDataCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 271.h,
      decoration: BoxDecoration(
        color: NbColors.black,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 23.h,
      ),
      child: GetBuilder<ManageDataController>(
          init: Get.find<ManageDataController>(),
          builder: (cntrl) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: NbText.sp16("Active Plan").w600.white),
                    _EditQuotaButton(onTap: _edit),
                  ],
                ),
                15.verticalSpace,
                NbText.sp16("MTN 4.2/10GB, GLO 2.32/3GB")
                    .w500
                    .setColor(const Color(0xFF929090)),
                15.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NbText.sp16("Account").w600.white,
                          16.verticalSpace,
                          Row(
                            children: [
                              numberChip("MTN 2392"),
                              10.horizontalSpace,
                              numberChip("MTN 2384"),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120.r,
                      height: 120.r,
                      child: CustomPaint(
                        painter: ArcPainter(
                          angle: 230,
                          thickness: 14.r,
                          backgroundColor: NbColors.white,
                          borderColor: NbColors.primary,
                        ),
                        child: Center(
                          child: NbText.sp22(percent(cntrl.dataManager.value))
                              .w400
                              .white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget numberChip(String txt) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xFFE9E9E9).withOpacity(0.19),
      ),
      child: NbText.sp14(txt).w500.white,
    );
  }

  void _edit() async {
    NbUtils.removeNav;
    await showModalBottomSheet(
      context: NbUtils.nav.currentContext!,
      builder: (context) => EditQuotaModal(
        totalData: "10",
        usedData: "2",
        periodEnum: PeriodEnum.day,
      ),
      isScrollControlled: true,
    );
    NbUtils.showNav;
  }

  String percent(DataManagement data) {
    int total = 0;
    int remaining = 0;
    for (var dt in data.simData) {
      total += dt.totalData;
      remaining += dt.remainingData;
    }
    double ratio;
    if (total <= 0) {
      ratio = 0;
    } else {
      ratio = remaining / total;
    }
    return "${ratio.round()}%";
  }
}

class _EditQuotaButton extends StatelessWidget {
  final void Function() onTap;
  const _EditQuotaButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: const Color(0xFFE9E9E9).withOpacity(0.19),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp16("Edit quota").w400.setColor(const Color(0xFFFBFBFB)),
            8.horizontalSpace,
            SvgPicture.asset(
              NbSvg.edit,
              width: 15.w,
              colorFilter:
                  const ColorFilter.mode(NbColors.white, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double angle;
  final double thickness;
  final Color borderColor;
  final Color backgroundColor;

  ArcPainter(
      {super.repaint,
      required this.angle,
      required this.thickness,
      required this.borderColor,
      required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;
    final Paint paintStroke = Paint()
      ..isAntiAlias = true
      ..strokeWidth = thickness
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final Paint paintBg = Paint()
      ..isAntiAlias = true
      ..strokeWidth = thickness
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(x / 2, y / 2), x / 2, paintBg);

    canvas.drawArc(
        Rect.fromCenter(
          center: Offset(x / 2, y / 2),
          width: x,
          height: y,
        ),
        -(math.pi * 0.5),
        (math.pi * angle / 180),
        false,
        paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

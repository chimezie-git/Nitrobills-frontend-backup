import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class NbHeader {
  static Row backAndTitle(
    String title,
    void Function() onBackPress, {
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
  }) {
    return Row(
      children: [
        NbButton.backIcon(onBackPress),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize ?? 22.sp,
              fontWeight: fontWeight ?? FontWeight.w500,
              color: color ?? NbColors.darkGrey,
            ),
          ),
        ),
        SizedBox(width: 24.w),
      ],
    );
  }
}

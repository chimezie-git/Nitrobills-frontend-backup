import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class NbButton {
  static Widget primary({
    required String text,
    required void Function() onTap,
    ButtonEnum status = ButtonEnum.active,
  }) {
    return BallLoaderButton(text: text, onTap: onTap, status: status);
  }

  static Widget primaryBoolLoader({
    required String text,
    required void Function() onTap,
    required bool isLoading,
  }) {
    return BallLoaderButton(
      text: text,
      onTap: onTap,
      status: isLoading ? ButtonEnum.loading : ButtonEnum.active,
    );
  }

  /// button with states of disabled loader and active where disabled
  ///  is the initial state and active is a success state
  static Widget primary3States({
    required String text,
    required void Function() onTap,
    ButtonEnum status = ButtonEnum.disabled,
  }) {
    return CircleLoaderButton(text: text, onTap: onTap, status: status);
  }

  static Widget outlinedPrimary(
      {required String text, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: NbColors.black),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: NbColors.black,
          ),
        ),
      ),
    );
  }

  static backIcon(void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 25.w,
        height: 25.w,
        child: Center(
            child: SvgPicture.asset(
          NbSvg.arrowBack,
          width: 15.w,
          colorFilter:
              const ColorFilter.mode(Color(0xFF282828), BlendMode.srcIn),
        )),
      ),
    );
  }

  static closeIcon(void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 25.w,
        height: 25.w,
        child: Center(
            child: SvgPicture.asset(
          NbSvg.close,
          width: 14.w,
          colorFilter: const ColorFilter.mode(NbColors.black, BlendMode.srcIn),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitrobills/app/data/enums/toast_type_enum.dart';

class NbToast {
  static Duration _toastDuration = const Duration(seconds: 2);
  static final FToast fToast = FToast();
  // methods

  static void init(BuildContext context) {
    fToast.init(context);
  }

  static Widget toast(ToastTypeEnum toastType, String message) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        width: 334.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: toastType.bgColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              toastType.svg,
              colorFilter:
                  ColorFilter.mode(toastType.textColor, BlendMode.srcIn),
              width: 20.r,
              height: 20.r,
              fit: BoxFit.contain,
            ),
            16.horizontalSpace,
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: toastType.textColor,
                ),
              ),
            ),
          ],
        ),
      );

  static void _showToast(ToastTypeEnum type, String message) {
    fToast.removeCustomToast();
    fToast.showToast(
      child: toast(type, message),
      positionedToastBuilder: (context, widget) {
        return Positioned(top: 70.h, left: 16.w, right: 16.w, child: widget);
      },
      toastDuration: _toastDuration,
    );
  }

  static void show(String message,
      {ToastTypeEnum type = ToastTypeEnum.info,
      Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(type, message);
  }

  static void info(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.info, message);
  }

  static void success(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.info, message);
  }

  static void error(String message,
      {Duration duration = const Duration(seconds: 4)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.error, message);
  }

  static void copy(String message,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.copy, message);
  }
}

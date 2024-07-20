import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitrobills/app/data/enums/toast_type_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class NbToast {
  static Duration _toastDuration = const Duration(seconds: 2);
  static final FToast fToast = FToast();
  // methods

  static void init(BuildContext context) {
    fToast.init(context);
  }

  static Widget toast(ToastTypeEnum toastType, String message) {
    switch (toastType) {
      case ToastTypeEnum.copy:
        return _CopyToastWidget(message: message);
      case ToastTypeEnum.error:
        return _ToastWidget(
          message: message,
          bgColor: 0xFFFAD2D2,
          mainColor: 0xFFC24914,
          svgColor: 0xFFC24914,
          onTap: _removeToast,
        );
      case ToastTypeEnum.info:
        return _ToastWidget(
          message: message,
          bgColor: 0xFFFFE999,
          mainColor: 0xFFC2A614,
          svgColor: 0xFFC2A614,
          onTap: _removeToast,
        );
      case ToastTypeEnum.success:
        return _ToastWidget(
          message: message,
          bgColor: 0xFF73FFB4,
          mainColor: 0xFF11A783,
          svgColor: 0xFF11A783,
          onTap: _removeToast,
        );
    }
  }

  static void _showToast(
      ToastTypeEnum type, String message, BuildContext context) {
    _showToastWidget(toast(type, message), context);
  }

  static void _showToastWidget(Widget toastWidget, BuildContext context) {
    init(context);
    fToast.removeCustomToast();

    fToast.showToast(
      child: toastWidget,
      positionedToastBuilder: (context, widget) {
        return Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          child: widget,
        );
      },
      isDismissable: true,
      toastDuration: _toastDuration,
    );
  }

  static void _removeToast() {
    fToast.removeCustomToast();
  }

  static void show(BuildContext context, String message,
      {ToastTypeEnum type = ToastTypeEnum.info,
      Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(type, message, context);
  }

  static void info(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.info, message, context);
  }

  static void success(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.success, message, context);
  }

  static void error(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 4)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.error, message, context);
  }

  static void copy(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToast(ToastTypeEnum.copy, message, context);
  }

  static void updateBalance(BuildContext context,
      {Duration duration = const Duration(seconds: 2)}) {
    _toastDuration = duration;
    _showToastWidget(const _UpdateBalanceToastWidget(), context);
  }

  static void fetchAccount(BuildContext context,
      {Duration duration = const Duration(seconds: 4)}) {
    _toastDuration = duration;
    _showToastWidget(const _FetchAccountToastWidget(), context);
  }
}

class _CopyToastWidget extends StatelessWidget {
  final String message;
  const _CopyToastWidget({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.w,
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xFF201A1A),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          8.horizontalSpace,
          SvgPicture.asset(
            NbSvg.copy,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 20.r,
            height: 20.r,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final int bgColor;
  final int mainColor;
  final int svgColor;
  final void Function() onTap;

  const _ToastWidget({
    required this.message,
    required this.bgColor,
    required this.mainColor,
    required this.svgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 335.w,
          height: 59.r,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                height: 16.r,
                left: 0,
                right: 0,
                child: Container(
                  width: 335.w,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.r)),
                    color: Color(bgColor),
                    border: Border(
                      bottom: BorderSide(
                        color: Color(bgColor),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 13.w,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 59.r,
                  height: 59.r,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(mainColor),
                  ),
                  child: SvgPicture.asset(
                    NbSvg.exclamation,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 335.w,
          padding: EdgeInsets.fromLTRB(15.r, 0, 15.r, 16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
            color: Color(bgColor),
            border: Border.all(
              color: Color(bgColor),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                NbSvg.toastSpark,
                colorFilter: ColorFilter.mode(Color(svgColor), BlendMode.srcIn),
                width: 47.r,
              ),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Color(mainColor),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              8.horizontalSpace,
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  NbSvg.close,
                  colorFilter:
                      ColorFilter.mode(Color(mainColor), BlendMode.srcIn),
                  width: 18.r,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpdateBalanceToastWidget extends StatelessWidget {
  const _UpdateBalanceToastWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 10.r),
          margin: EdgeInsets.fromLTRB(0, 20.r, 0, 0),
          decoration: BoxDecoration(
            color: const Color(0xFFededed),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                NbSvg.wallet,
                width: 18.r,
                colorFilter:
                    const ColorFilter.mode(NbColors.black, BlendMode.srcIn),
              ),
              8.horizontalSpace,
              NbText.sp15("Updating balance").w400
            ],
          ),
        ),
      ],
    );
  }
}

class _FetchAccountToastWidget extends StatelessWidget {
  const _FetchAccountToastWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      margin: EdgeInsets.fromLTRB(20.w, 20.r, 20.w, 0),
      decoration: BoxDecoration(
        color: const Color(0xFFededed),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            NbSvg.wallet,
            width: 18.r,
            colorFilter:
                const ColorFilter.mode(NbColors.black, BlendMode.srcIn),
          ),
          8.horizontalSpace,
          Expanded(
              child: NbText.sp15(
                      "Were fetching your account details check back in a little while.")
                  .w400)
        ],
      ),
    );
  }
}

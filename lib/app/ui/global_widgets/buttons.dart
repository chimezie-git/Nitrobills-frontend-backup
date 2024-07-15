import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_json.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BallLoaderButton extends StatefulWidget {
  final String text;
  final void Function() onTap;
  final ButtonEnum status;

  const BallLoaderButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.status});

  @override
  State<BallLoaderButton> createState() => _BallLoaderButtonState();
}

class _BallLoaderButtonState extends State<BallLoaderButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.status.bgColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onDoubleTap: null,
        borderRadius: BorderRadius.circular(16.r),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFF0E9ECA).withOpacity(0.13),
        ),
        splashFactory: InkRipple.splashFactory,
        onTap: widget.status.isActive ? widget.onTap : null,
        child: Container(
          height: 60.h,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: widget.status.isLoading
              ? Lottie.asset(
                  NbLottie.ballLoader,
                  height: 60.h,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: widget.status.textColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class GreyDoubleTextButton extends StatelessWidget {
  final void Function() onTap;
  final String text1;
  final String text2;

  const GreyDoubleTextButton(
      {super.key,
      required this.onTap,
      required this.text1,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE8E7E7),
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onDoubleTap: null,
        borderRadius: BorderRadius.circular(16.r),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFF0E9ECA).withOpacity(0.13),
        ),
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        child: Container(
          height: 60.h,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: "$text1 ",
              style: TextStyle(
                color: const Color(0xFF2F3336),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Satoshi',
              ),
              children: [
                TextSpan(
                    text: "$text2 ",
                    style: const TextStyle(
                      color: Color(0xFF1E92E9),
                      fontFamily: 'Satoshi',
                      decoration: TextDecoration.underline,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GreyTextSvgButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final String svg;

  const GreyTextSvgButton(
      {super.key, required this.onTap, required this.text, required this.svg});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE8E7E7),
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onDoubleTap: null,
        borderRadius: BorderRadius.circular(16.r),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFF0E9ECA).withOpacity(0.13),
        ),
        splashFactory: InkRipple.splashFactory,
        onTap: onTap,
        child: Container(
          height: 60.h,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svg,
                width: 24.r,
              ),
              24.horizontalSpace,
              NbText.sp16(text).w500.setColor(const Color(0xFF282828)),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleLoaderButton extends StatefulWidget {
  final String text;
  final void Function() onTap;
  final ButtonEnum status;

  const CircleLoaderButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.status});

  @override
  State<CircleLoaderButton> createState() => _CircleLoaderButtonState();
}

class _CircleLoaderButtonState extends State<CircleLoaderButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.status.isDisabled ? widget.onTap : null,
      child: Container(
        height: 60.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: widget.status.bgColor,
        ),
        child: widget.status.isLoading
            ? Lottie.asset(
                NbLottie.circleLoader,
                height: 41.h,
                controller: _controller,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward();
                },
              )
            : (widget.status.isDisabled
                ? Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: NbColors.white,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(15.r),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset(NbSvg.greenCheck),
                    ),
                  )),
      ),
    );
  }
}

class BlackWidgetButton extends StatelessWidget {
  const BlackWidgetButton(
      {super.key,
      required this.child,
      required this.onTap,
      required this.status});

  final Widget child;
  final void Function() onTap;
  final ButtonEnum status;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: status.bgColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onDoubleTap: null,
        borderRadius: BorderRadius.circular(16.r),
        overlayColor: WidgetStatePropertyAll(
          const Color(0xFF0E9ECA).withOpacity(0.13),
        ),
        splashFactory: InkRipple.splashFactory,
        onTap: status.isActive ? onTap : null,
        child: Container(
          height: 60.h,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class PayNowButton extends StatelessWidget {
  final ButtonEnum status;
  final void Function() onTap;

  const PayNowButton({
    super.key,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: status.isActive ? onTap : null,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 56.h,
        width: 154.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: status.isDisabled ? const Color(0xFFEFEFEF) : NbColors.black,
        ),
        child: status.isLoading
            ? SizedBox(
                width: 24.r,
                height: 24.r,
                child: const CircularProgressIndicator(
                  color: NbColors.white,
                  strokeCap: StrokeCap.round,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NbText.sp14("Pay now").w700.setColor(status.isDisabled
                      ? const Color(0xFF212121)
                      : NbColors.white),
                  16.horizontalSpace,
                  SvgPicture.asset(
                    NbSvg.checkRounded,
                    width: 20.r,
                    height: 20.r,
                    colorFilter: ColorFilter.mode(
                      status.isDisabled
                          ? const Color(0xFF212121)
                          : NbColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ProceedButton extends StatelessWidget {
  final ButtonEnum status;
  final void Function() onTap;

  const ProceedButton({
    super.key,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: status.isActive ? onTap : null,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 56.h,
        width: 154.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: status.isDisabled ? const Color(0xFFEFEFEF) : NbColors.black,
        ),
        child: status.isLoading
            ? SizedBox(
                width: 24.r,
                height: 24.r,
                child: const CircularProgressIndicator(
                  color: NbColors.white,
                  strokeCap: StrokeCap.round,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NbText.sp14("Proceed").w700.setColor(status.isDisabled
                      ? const Color(0xFF212121)
                      : NbColors.white),
                  16.horizontalSpace,
                  RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      NbSvg.arrowBack,
                      width: 15.r,
                      height: 15.r,
                      colorFilter: ColorFilter.mode(
                        status.isDisabled
                            ? const Color(0xFF212121)
                            : NbColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

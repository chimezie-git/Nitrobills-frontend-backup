import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_json.dart';

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
    return InkWell(
      onTap: widget.status.isLoading ? null : widget.onTap,
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
                  color: NbColors.white,
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

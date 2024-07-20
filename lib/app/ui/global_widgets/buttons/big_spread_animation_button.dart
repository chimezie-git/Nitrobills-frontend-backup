import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BigSpreadAnimationButton extends StatefulWidget {
  const BigSpreadAnimationButton({
    super.key,
    required this.status,
  });

  final ButtonEnum status;

  @override
  State<BigSpreadAnimationButton> createState() =>
      _BigSpreadAnimationButtonState();
}

class _BigSpreadAnimationButtonState extends State<BigSpreadAnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.0), weight: 0.6),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.5), weight: 0.4),
    ]).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: AnimatedContainer(
              duration: duration,
              width: 327.w,
              height: 72.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: widget.status.bgColor,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NbText.sp16("Proceed").w500.setColor(widget.status.textColor),
                  SizedBox(
                    width: 30.w * animation.value,
                  ),
                  SvgPicture.asset(
                    NbSvg.arrowBack,
                    colorFilter: ColorFilter.mode(
                      widget.status.textColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

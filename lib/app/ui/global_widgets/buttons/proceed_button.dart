import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/loaders/circle_loader.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ProceedButton extends StatefulWidget {
  final void Function() onTap;

  const ProceedButton({
    super.key,
    required this.status,
    required this.onTap,
  });

  final ButtonEnum status;

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton>
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
            onTap: widget.status.isActive
                ? () async {
                    controller.reset();
                    await controller.forward();
                    widget.onTap();
                  }
                : null,
            child: AnimatedContainer(
              duration: duration,
              width: 154.w,
              height: 53.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: widget.status.bgColor,
              ),
              child: widget.status.isLoading
                  ? const CircleLoader()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NbText.sp14("Proceed")
                            .w500
                            .setColor(widget.status.textColor),
                        SizedBox(
                          width: 20.w * animation.value,
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SvgPicture.asset(
                            NbSvg.arrowBack,
                            colorFilter: ColorFilter.mode(
                                widget.status.textColor, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}

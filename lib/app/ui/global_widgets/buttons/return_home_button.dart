import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ReturnHomeButton extends StatefulWidget {
  final void Function() onTap;
  const ReturnHomeButton({
    super.key,
    required this.status,
    required this.onTap,
  });

  final ButtonEnum status;

  @override
  State<ReturnHomeButton> createState() => _ReturnHomeButtonState();
}

class _ReturnHomeButtonState extends State<ReturnHomeButton>
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
          onTap: () async {
            controller.reset();
            await controller.forward();
            widget.onTap();
          },
          child: AnimatedContainer(
            duration: duration,
            width: 154.w,
            height: 53.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: bgColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NbText.sp14("Return home")
                    .w500
                    .setColor(widget.status.textColor),
                SizedBox(
                  width: 25.w * animation.value,
                ),
                SvgPicture.asset(
                  NbSvg.trashCan,
                  width: 16.w,
                  colorFilter: ColorFilter.mode(
                      widget.status.textColor, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color get bgColor {
    if (widget.status == ButtonEnum.active) {
      return NbColors.black;
    } else {
      return const Color(0xFFF0F0F0);
    }
  }
}

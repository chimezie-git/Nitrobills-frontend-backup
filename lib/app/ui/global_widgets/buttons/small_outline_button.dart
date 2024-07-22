import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class SmallOutlineButton extends StatefulWidget {
  final String text;
  final void Function() onTap;

  const SmallOutlineButton(
      {super.key, required this.onTap, required this.text});

  @override
  State<SmallOutlineButton> createState() => _SmallOutlineButtonState();
}

class _SmallOutlineButtonState extends State<SmallOutlineButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 0.7),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.0), weight: 0.3),
    ]).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            width: 154.w,
            height: 53.h,
            alignment: Alignment.center,
            child: Transform.scale(
              scale: animation.value,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () async {
                  controller.reset();
                  await controller.forward();
                  widget.onTap();
                },
                child: Container(
                  width: 154.w,
                  height: 53.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: NbColors.black),
                  ),
                  child: NbText.sp14(widget.text).w500.setColor(
                        const Color(0xFF252424),
                      ),
                ),
              ),
            ),
          );
        });
  }
}

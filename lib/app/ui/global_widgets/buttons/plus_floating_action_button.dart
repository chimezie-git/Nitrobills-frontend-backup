import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class PlusFloatingActionButton extends StatefulWidget {
  final void Function() onTap;

  const PlusFloatingActionButton({super.key, required this.onTap});

  @override
  State<PlusFloatingActionButton> createState() =>
      _PlusFloatingActionButtonState();
}

class _PlusFloatingActionButtonState extends State<PlusFloatingActionButton>
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
          return InkWell(
            borderRadius: BorderRadius.circular(24.r),
            onTap: () {
              controller.reset();
              controller.forward();
              widget.onTap();
            },
            child: Transform.scale(
              scale: animation.value,
              child: Container(
                width: 72.w,
                height: 72.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: NbColors.black,
                ),
                child: Icon(
                  Icons.add,
                  color: NbColors.white,
                  size: 34.r,
                ),
              ),
            ),
          );
        });
  }
}

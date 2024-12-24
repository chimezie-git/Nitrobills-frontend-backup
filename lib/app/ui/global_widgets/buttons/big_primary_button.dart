import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/loaders/ball_loader.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BigPrimaryButton extends StatefulWidget {
  const BigPrimaryButton({
    super.key,
    required this.status,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;
  final ButtonEnum status;

  @override
  State<BigPrimaryButton> createState() => _BigPrimaryButtonState();
}

class _BigPrimaryButtonState extends State<BigPrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 0.0, end: 2.4).animate(controller);
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
            child: SizedBox(
              width: double.maxFinite,
              height: 72.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: AnimatedContainer(
                      duration: duration,
                      width: double.maxFinite,
                      height: 72.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: widget.status.bgColor,
                      ),
                      child: widget.status.isLoading
                          ? null
                          : NbText.sp16(widget.text)
                              .w500
                              .setColor(widget.status.textColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment((animation.value - 1.2), 0),
                    child: Transform.rotate(
                      angle: 0.2,
                      child: Container(
                        height: 97.h,
                        width: 26.w,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  if (widget.status.isLoading)
                    Positioned(
                      top: -9.h,
                      left: 0,
                      right: 0,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BallLoader(),
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/loaders/ball_loader.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ElevatedPrimaryButton extends StatefulWidget {
  const ElevatedPrimaryButton({
    super.key,
    required this.status,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;
  final ButtonEnum status;

  @override
  State<ElevatedPrimaryButton> createState() => _ElevatedPrimaryButtonState();
}

class _ElevatedPrimaryButtonState extends State<ElevatedPrimaryButton>
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
              height: 60.h,
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
                      height: 60.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: widget.status.bgColor,
                          boxShadow: widget.status.isActive
                              ? [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    color: const Color(0xFF665C5C)
                                        .withOpacity(0.25),
                                  ),
                                ]
                              : null),
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
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFCFCFCF).withOpacity(0.13),
                              const Color(0xFF91DFF7).withOpacity(0.13),
                              const Color(0xFF67ADC4).withOpacity(0.13),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.status.isLoading)
                    const Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      child: BallLoader(),
                    ))
                ],
              ),
            ),
          );
        });
  }
}

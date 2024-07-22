import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/loaders/ball_loader.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BigProceedButton extends StatefulWidget {
  const BigProceedButton({
    super.key,
    required this.status,
    required this.onTap,
  });

  final void Function() onTap;
  final ButtonEnum status;

  @override
  State<BigProceedButton> createState() => _BigProceedButtonState();
}

class _BigProceedButtonState extends State<BigProceedButton>
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
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                NbText.sp16("Proceed")
                                    .w500
                                    .setColor(widget.status.textColor),
                                40.horizontalSpace,
                                RotatedBox(
                                  quarterTurns: 2,
                                  child: SvgPicture.asset(
                                    NbSvg.arrowBack,
                                    colorFilter: ColorFilter.mode(
                                        widget.status.textColor,
                                        BlendMode.srcIn),
                                  ),
                                ),
                              ],
                            ),
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

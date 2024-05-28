import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/pages/onboarding/intro_page.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final Duration _delay = const Duration(seconds: 1);
  final Duration _duration = const Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: _duration,
      vsync: this,
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextPage();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startAnimation();
    });
  }

  Future _startAnimation() async {
    await Future.delayed(_delay);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 1.h,
              left: 5.w,
              right: 5.w,
              height: 110.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFF434242),
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: NbColors.primary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 267.h,
                      height: 103.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 103.h,
                            width: 103.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  NbImage.logoNoSpark,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                AnimatedBuilder(
                                    animation: controller,
                                    builder: (context, child) {
                                      return Positioned(
                                        bottom: 35.h *
                                            controller
                                                .value, //animate from zero to 35
                                        left: 0,
                                        right: 0,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Opacity(
                                            opacity: controller.value,
                                            child: Image.asset(
                                              NbImage.logoSpark,
                                              width: 14.w,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          return Positioned(
                            top: 787.h -
                                (400.h *
                                    controller.value), // from 700.h to 387.h
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: NbText.sp40("Nitro bills").w700.white),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    AuthModal.show(const IntroPage());
  }
}

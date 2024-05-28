import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/auth/signin_page.dart';
import 'package:nitrobills/app/ui/pages/auth/signup_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final int pageCount = 3;
  final Duration _delay = const Duration(seconds: 4);
  final Duration _animation = const Duration(milliseconds: 400);
  late final PageController controller;
  late final Timer _timer;
  int _counter = 0;

  @override
  void initState() {
    controller = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initTimer();
    });
    super.initState();
  }

  void initTimer() {
    _timer = Timer.periodic(
      _delay,
      (timer) {
        _counter++;
        controller.animateToPage((_counter % pageCount),
            duration: _animation, curve: Curves.easeIn);
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
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
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r)),
                            child: PageView(
                              controller: controller,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Image.asset(
                                  NbImage.onboarding1,
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  NbImage.onboarding2,
                                  fit: BoxFit.cover,
                                ),
                                Image.asset(
                                  NbImage.onboarding3,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 7.w,
                            right: 7.w,
                            bottom: 20.h,
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFF010000).withOpacity(0.36),
                                borderRadius: BorderRadius.circular(18.r),
                              ),
                              child: NbText.sp25(
                                      "Buy Data pay bills and send bulk sms.")
                                  .white
                                  .w400
                                  .centerText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          15.verticalSpace,
                          SmoothPageIndicator(
                              controller: controller, // PageController
                              count: pageCount,
                              effect: SwapEffect(
                                dotHeight: 6.r,
                                dotWidth: 25.r,
                                spacing: 2.5.r,
                                dotColor: const Color(0xFFD9D9D9),
                                activeDotColor: NbColors.black,
                              ), // your preferred effect
                              onDotClicked: (index) {}),
                          15.verticalSpace,
                          NbButton.primary(text: "Sign up", onTap: _signup),
                          17.verticalSpace,
                          InkWell(
                              onTap: _signin,
                              child: Container(
                                padding: EdgeInsets.all(2.r),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: NbColors.primary),
                                  ),
                                ),
                                child: Text(
                                  " Sign in ",
                                  style: TextStyle(
                                    color: NbColors.primary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                              // .w500.underline.setColor(NbColors.primary),
                              ),
                          25.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signup() {
    AuthModal.show(const SignupPage());
  }

  void _signin() {
    AuthModal.show(const SigninPage());
  }
}

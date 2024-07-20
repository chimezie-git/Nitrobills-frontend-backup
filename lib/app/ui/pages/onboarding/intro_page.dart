import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
// import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/elevated_primary_button.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/white_grey_auth_button.dart';
// import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/auth/signin_page.dart';
import 'package:nitrobills/app/ui/pages/auth/signup_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  final int pageCount = 4;
  final Duration _delay = const Duration(seconds: 4);
  final Duration _animation = const Duration(milliseconds: 400);
  late final TabController controller;
  Timer? _timer;
  int _counter = 0;

  @override
  void initState() {
    NbToast.init(context);
    controller = TabController(length: 4, vsync: this);
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
        controller.animateTo((_counter % pageCount),
            duration: _animation, curve: Curves.easeIn);
      },
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!(_timer?.isActive ?? true)) {
  //     debugPrint("------------Activate-------------");
  //     initTimer();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        resizeToAvoidBottomInset: false,
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
                    SizedBox(
                      height: 323.h,
                      width: double.maxFinite,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.r)),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: TabBarView(
                                controller: controller,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  onboardingImage(NbImage.onboarding1),
                                  onboardingImage(NbImage.onboarding2),
                                  onboardingImage(NbImage.onboarding3),
                                  onboardingImage(NbImage.onboarding4),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10.h,
                              left: 10.r,
                              right: 10.r,
                              child: TabBar(
                                onTap: (idx) {
                                  _counter = idx;
                                  if (_timer == null) {
                                    initTimer();
                                  }
                                },
                                dividerColor: Colors.transparent,
                                dividerHeight: 0,
                                indicatorColor: Colors.white,
                                controller: controller,
                                unselectedLabelColor:
                                    Colors.white.withOpacity(0.6),
                                labelColor: Colors.white,
                                labelStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                labelPadding: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                tabs: [
                                  tab("Network"),
                                  tab("Cable"),
                                  tab("Betting"),
                                  tab("Electricity"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        color: Colors.white,
                        child: TabBarView(
                          controller: controller,
                          children: [
                            _textTab("Cheapest Data rates in Nigeria.",
                                "Use the quickest and most affordable data service for all the major networks"),
                            _textTab("Fastest Cable TV payments in Nigeria.",
                                "Enjoy quicker, more affordable, and automated subscription services for all major providers."),
                            _textTab("Lowest Betting Fees in Nigeria.",
                                "Enjoy discount account funding in Nigeria. Enjoy automated, fast, and easy transactions across all major betting platforms."),
                            _textTab("Fastest Electricity Payments in Nigeria.",
                                "Enjoy quick and easy bill settlements across major providers. Automated, affordable, and reliable."),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: NbColors.white),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedPrimaryButton(
                            status: ButtonEnum.active,
                            text: "Create an account",
                            onTap: _signup,
                          ),
                          28.verticalSpace,
                          WhiteGreyAuthButton(
                            text1: "Already with nitro?",
                            text2: "Sign in",
                            onTap: _signin,
                          ),
                          35.verticalSpace,
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

  Tab tab(String label) => Tab(
        iconMargin: EdgeInsets.zero,
        text: label,
      );

  Padding _textTab(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        12.verticalSpace,
        NbText.sp22(title).w600,
        24.verticalSpace,
        NbText.sp18(subtitle).w500,
      ]),
    );
  }

  Image onboardingImage(String img) {
    return Image.asset(
      img,
      height: double.maxFinite,
      width: double.maxFinite,
      fit: BoxFit.cover,
    );
  }

  void _signup() {
    _timer?.cancel();
    _timer = null;
    AuthModal.show(const SignupPage());
  }

  void _signin() {
    _timer?.cancel();
    _timer = null;
    AuthModal.show(const SigninPage());
  }
}

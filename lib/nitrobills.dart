import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/bindings/initial_bindings.dart';
import 'package:nitrobills/app/ui/global_widgets/tab_overlay.dart';
import 'package:nitrobills/app/ui/pages/onboarding/splash_page.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class NitroBills extends StatelessWidget {
  const NitroBills({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, context) {
        return GetMaterialApp(
          title: 'Nitro Bills',
          navigatorKey: NbUtils.nav,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'Satoshi',
            scaffoldBackgroundColor: NbColors.background,
          ),
          initialBinding: InitialBinding(),
          builder: (context, child) => TabOverlay(child: child ?? Container()),
          home: const SplashPage(),
        );
      },
    );
  }
}

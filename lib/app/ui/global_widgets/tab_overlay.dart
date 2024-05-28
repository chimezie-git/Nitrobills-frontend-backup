import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';
import 'package:nitrobills/app/ui/pages/account/account_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/beneficiaries_page.dart';
import 'package:nitrobills/app/ui/pages/home/home_page.dart';
import 'package:nitrobills/app/ui/pages/manage_data/manage_data_page.dart';
import 'package:nitrobills/app/ui/pages/transactions/transactions_page.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_contants.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class TabOverlay extends StatelessWidget {
  final Widget child;
  const TabOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: child,
        ),
        GetX<NavbarController>(
          init: NavbarController(),
          builder: (cntr) {
            // if (cntr.showTab.value) {
            return AnimatedPositioned(
              duration: NbContants.navDuration,
              bottom: cntr.showTab.value ? 8.h : -70.h,
              right: 17.w,
              left: 17.w,
              height: 69.9.h,
              child: Material(
                color: NbColors.primary,
                borderRadius: BorderRadius.circular(18.r),
                child: Row(
                  children: [
                    tabIcon(
                      NbSvg.home,
                      NbSvg.homeFilled,
                      0,
                      cntr.tabIndex.value == 0,
                    ),
                    tabIcon(
                      NbSvg.stat,
                      NbSvg.statFilled,
                      1,
                      cntr.tabIndex.value == 1,
                    ),
                    tabIcon(
                      NbSvg.dollar,
                      NbSvg.dollarFilled,
                      2,
                      cntr.tabIndex.value == 2,
                    ),
                    tabIcon(
                      NbSvg.addSquare,
                      NbSvg.addSquareFilled,
                      3,
                      cntr.tabIndex.value == 3,
                    ),
                    tabIcon(
                      NbSvg.profile,
                      NbSvg.profileFilled,
                      4,
                      cntr.tabIndex.value == 4,
                    ),
                  ],
                ),
              ),
            );
            // } else {
            //   return const SizedBox.shrink();
            // }
          },
        ),
      ],
    );
  }

  Widget tabIcon(
    String outlinedIcon,
    String filledIcon,
    int tabIndex,
    bool selected,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          int currentIndex = Get.find<NavbarController>().tabIndex.value;
          if (currentIndex != tabIndex) {
            Get.find<NavbarController>().changeIndex(tabIndex);
            await NbUtils.nav.currentState?.push(
              MaterialPageRoute(builder: (context) => _pages[tabIndex]),
            );
            Get.find<NavbarController>().changeIndex(currentIndex);
          }
        },
        child: Center(
          child: SizedBox(
            // width: 20.w,
            height: 20.w,
            // child: Icon(Icons.home),
            child: SvgPicture.asset(
              selected ? filledIcon : outlinedIcon,
              // colorFilter:
              //     const ColorFilter.mode(NbColors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }

  static const List<Widget> _pages = [
    HomePage(),
    ManageDataPage(),
    TransactionsPage(),
    BeneficiariesPage(),
    AccountPage(),
  ];
}

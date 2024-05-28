import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/pay_airtime_page.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/pay_betting_page.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/pay_cable_tv_page.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/pay_electricity_page.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/widgets/pay_bills_list_tile.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class PayBillsPage extends StatelessWidget {
  const PayBillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<(String, ServiceTypesEnum)> bills = [
      (NbImage.mtn, ServiceTypesEnum.airtime),
      (NbImage.dstv, ServiceTypesEnum.cable),
      (NbImage.bet9ja, ServiceTypesEnum.betting),
      (NbImage.eedc, ServiceTypesEnum.electricity),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                36.verticalSpace,
                NbHeader.backAndTitle(
                  "Pay Bills",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                17.verticalSpace,
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bills.length,
                    separatorBuilder: (context, index) {
                      return 24.verticalSpace;
                    },
                    itemBuilder: (context, index) {
                      String img = bills[index].$1;
                      ServiceTypesEnum se = bills[index].$2;
                      return PayBillsListTile(
                        image: img,
                        text: se.name,
                        onTap: () {
                          _payBills(se);
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _payBills(ServiceTypesEnum se) {
    switch (se) {
      case ServiceTypesEnum.airtime:
        Get.to(() => const PayAirtimePage());
        break;
      case ServiceTypesEnum.cable:
        Get.to(() => const PayCableTvPage());
        break;
      case ServiceTypesEnum.betting:
        Get.to(() => const PayBettingPage());
        break;
      case ServiceTypesEnum.electricity:
        Get.to(() => const PayElectricityPage());
        break;
      default:
        throw Exception("Option Not available");
    }
    // Get.to(() => page);
  }
}

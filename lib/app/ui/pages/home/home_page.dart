import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';
import 'package:nitrobills/app/ui/pages/bulk_sms/bulk_sms_page.dart';
import 'package:nitrobills/app/ui/pages/buy_data/buy_data_page.dart';
import 'package:nitrobills/app/ui/pages/home/models/bank_info.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/pay_bills_page.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/account_title_widget.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/top_payments_button_widget.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/user_bank_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF5F8),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              18.verticalSpace,
              AccountTitleWidget(amount: "N800", refresh: () {}),
              20.verticalSpace,
              UserBanksWidget(
                bankData: {
                  "Sterlin Bank": BankInfo.wema,
                  "Wema Bank": null,
                },
              ),
              40.verticalSpace,
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 0),
                color: NbColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NbText.sp16("Top Payments").w500.black,
                    14.verticalSpace,
                    Wrap(
                      runSpacing: 10.h,
                      spacing: 10.w,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        TopPaymentsButtonWidget(
                          svg: NbSvg.buyData,
                          title: "Buy Data",
                          subtitle: "MTN, Airtel, 9mobile, GlO",
                          onTap: () {
                            _closeOpenNav(const BuyDataPage());
                          },
                        ),
                        TopPaymentsButtonWidget(
                          svg: NbSvg.card,
                          title: "Pay Bills",
                          subtitle: "Buy airtime, Recharge decoder",
                          maxLines: 2,
                          onTap: () {
                            _closeOpenNav(const PayBillsPage());
                          },
                        ),
                        TopPaymentsButtonWidget(
                          svg: NbSvg.mail,
                          title: "Bulk SMS",
                          subtitle: "Send multiple SMS",
                          onTap: () {
                            _closeOpenNav(const BulkSMSPage());
                          },
                        ),
                      ],
                    ),
                    100.verticalSpace,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _closeOpenNav(Widget page) async {
    NavbarController cntrl = Get.find<NavbarController>();
    cntrl.toggleShowTab(false);
    await Get.to(() => page);
    cntrl.toggleShowTab(true);
  }
}

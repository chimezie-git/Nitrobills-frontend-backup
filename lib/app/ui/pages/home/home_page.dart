import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';
import 'package:nitrobills/app/ui/pages/bulk_sms/bulk_sms_page.dart';
import 'package:nitrobills/app/ui/pages/buy_data/buy_data_page.dart';
import 'package:nitrobills/app/ui/pages/home/home_loading_page.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/verify_phone_number_tile.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/pay_bills_page.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/account_title_widget.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/top_payments_button_widget.dart';
import 'package:nitrobills/app/ui/pages/home/widgets/user_bank_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    NbToast.init(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<UserAccountController>().initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<UserAccountController>(
      init: Get.find<UserAccountController>(),
      builder: (cntrl) {
        if (cntrl.status.value.isLoading) {
          return const HomeLoadingPage();
        } else {
          return Scaffold(
            backgroundColor: const Color(0xFFFAFAFA),
            body: RefreshIndicator(
              color: NbColors.black,
              backgroundColor: Colors.transparent,
              onRefresh: () async {
                await refresh();
              },
              child: SafeArea(
                bottom: false,
                child: ListView(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(NbImage.homeBgImg),
                          fit: BoxFit.cover,
                        ),
                        color: NbColors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          18.verticalSpace,
                          AccountTitleWidget(
                              amount: cntrl.totalAmount.toString(),
                              refresh: refresh),
                          10.verticalSpace,
                          const VerifyPhoneNumberTile(),
                          10.verticalSpace,
                          UserBanksWidget(
                            bankData: cntrl.account.value.banks,
                          ),
                          40.verticalSpace,
                        ],
                      ),
                    ),
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
                                onTap: () => _closeOpenNav(const BuyDataPage()),
                              ),
                              TopPaymentsButtonWidget(
                                svg: NbSvg.card,
                                title: "Pay Bills",
                                subtitle: "Buy airtime, Recharge decoder",
                                maxLines: 2,
                                onTap: () =>
                                    _closeOpenNav(const PayBillsPage()),
                              ),
                              TopPaymentsButtonWidget(
                                svg: NbSvg.mail,
                                title: "Bulk SMS",
                                subtitle: "Send multiple SMS",
                                onTap: () => _closeOpenNav(const BulkSMSPage()),
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
      },
    );
  }

  Future _closeOpenNav(Widget page) async {
    NavbarController cntrl = Get.find<NavbarController>();
    cntrl.toggleShowTab(false);
    await Get.to(() => page);
    cntrl.toggleShowTab(true);
  }

  Future refresh() async {
    NbToast.updateBalance(context);
    await Get.find<UserAccountController>().reload(showLoading: true);
  }
}

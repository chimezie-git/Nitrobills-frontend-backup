import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/autopay_controller.dart';
import 'package:nitrobills/app/ui/global_widgets/empty_fields_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/autopayments/widgets/autopayment_card_widgets.dart';
import 'package:nitrobills/app/ui/pages/autopayments/widgets/autopayment_tooltip.dart';
import 'package:nitrobills/app/ui/pages/autopayments/widgets/my_bills_card.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class ManageAutopaymentsPage extends StatelessWidget {
  const ManageAutopaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AutopayController>(
          init: Get.find<AutopayController>(),
          builder: (cntrl) {
            return RefreshIndicator(
              onRefresh: () async {
                await cntrl.reload(context);
              },
              backgroundColor: Colors.white,
              color: NbColors.black,
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
                        "Auto Payments",
                        () {
                          Get.back();
                        },
                        fontSize: 18.w,
                        fontWeight: FontWeight.w600,
                        color: NbColors.black,
                      ),
                      if (cntrl.autopay.isEmpty)
                        EmptyFieldsWidget(
                          image: NbImage.noAutopay,
                          text: "You don't have auto-payments set up yet.",
                          onTap: () {},
                          postfix: infoToolTip(),
                          btnText: "Click the plus button to add",
                        )
                      else
                        Expanded(
                          child: Column(
                            children: [
                              26.verticalSpace,
                              const MyBillsCard(billsDue: "0"),
                              40.verticalSpace,
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return AutopaymentCardWidget(
                                      autopay: cntrl.autopay[index],
                                      onTap: () {
                                        // Get.to(
                                        //   () => SetupAutopaymentPage(
                                        //     autopay: cntrl.autopay[index],
                                        //   ),
                                        // );
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      30.verticalSpace,
                                  itemCount: cntrl.autopay.length,
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
          }),
    );
  }

  Widget infoToolTip() {
    return ElTooltip(
      content: const AutopaymentTooltip(),
      radius: Radius.circular(16.r),
      // color: Colors.transparent,
      color: const Color(0xFFE0E0E0),
      position: ElTooltipPosition.topEnd,

      child: Container(
        width: 24.r,
        height: 24.r,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: NbColors.lightGrey,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          NbSvg.questionMark,
          width: 16.r,
          height: 16.r,
          colorFilter: const ColorFilter.mode(
            NbColors.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

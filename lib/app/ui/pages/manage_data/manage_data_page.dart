import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/manage_data_controller.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';
import 'package:nitrobills/app/ui/global_widgets/empty_fields_widget.dart';
import 'package:nitrobills/app/ui/pages/buy_data/buy_data_page.dart';
import 'package:nitrobills/app/ui/pages/manage_data/manage_data_loading_page.dart';
import 'package:nitrobills/app/ui/pages/manage_data/widget/data_chart_widget.dart';
import 'package:nitrobills/app/ui/pages/manage_data/widget/manage_data_card_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ManageDataPage extends StatelessWidget {
  const ManageDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      Get.find<ManageDataController>().initialize();
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: GetX<ManageDataController>(
            init: Get.find<ManageDataController>(),
            builder: (cntrl) {
              if (!cntrl.loaded.value) {
                return const ManageDataLoadingPage();
              } else {
                return Column(
                  children: [
                    18.verticalSpace,
                    NbText.sp18("Manage Data").w600.black,
                    16.verticalSpace,
                    if (cntrl.dataManager.value.enabled)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ManageDataCardWidget(),
                          32.verticalSpace,
                          const DataChartWidget(),
                        ],
                      )
                    else
                      EmptyFieldsWidget(
                        image: NbImage.noManageData,
                        text: "You dont have any active data subscription",
                        prefix: NbSvg.buyData,
                        onTap: _accessDataProvider,
                        btnText: "Access our data providers",
                      ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _accessDataProvider() async {
    Get.find<NavbarController>().toggleShowTab(false);
    await Get.to(const BuyDataPage());
    Get.find<NavbarController>().toggleShowTab(true);
  }
}

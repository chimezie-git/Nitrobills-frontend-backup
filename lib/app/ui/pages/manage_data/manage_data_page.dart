import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/manage_data_controller.dart';
import 'package:nitrobills/app/ui/global_widgets/empty_fields_widget.dart';
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
              if (cntrl.status.value.isLoading) {
                return const ManageDataLoadingPage();
              } else {
                return Column(
                  children: [
                    18.verticalSpace,
                    NbText.sp18("Manage Data").w600.black,
                    16.verticalSpace,
                    if (cntrl.status.value.isFailed)
                      const EmptyFieldsWidget(
                        image: NbImage.noManageData,
                        text: "You dont have any active data subscription",
                      )
                    else
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ManageDataCardWidget(),
                          32.verticalSpace,
                          DataChartWidget(),
                        ],
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
}

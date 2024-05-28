import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/global_widgets/empty_fields_widget.dart';
import 'package:nitrobills/app/ui/pages/manage_data/widget/data_chart_widget.dart';
import 'package:nitrobills/app/ui/pages/manage_data/widget/manage_data_card_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ManageDataPage extends StatelessWidget {
  const ManageDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: Column(
            children: [
              18.verticalSpace,
              NbText.sp18("Manage Data").w600.black,
              16.verticalSpace,
              if (false)
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
          ),
        ),
      ),
    );
  }
}

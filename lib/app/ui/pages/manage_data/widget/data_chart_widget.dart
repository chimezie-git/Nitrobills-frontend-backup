import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/manage_data_controller.dart';
import 'package:nitrobills/app/ui/global_widgets/custom_date_range_picker_dialog.dart';
import 'package:nitrobills/app/ui/pages/manage_data/models/day_data.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class DataChartWidget extends StatefulWidget {
  const DataChartWidget({super.key});

  @override
  State<DataChartWidget> createState() => _DataChartWidgetState();
}

class _DataChartWidgetState extends State<DataChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: NbText.sp20("Active Plan").w600.black),
            _analysisButton(_getDataRange),
          ],
        ),
        15.verticalSpace,
        BarChart()
      ],
    );
  }

  Widget _analysisButton(void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: const Color(0xFFE2DADA),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp16("Analysis").w400.darkGrey,
            16.horizontalSpace,
            SvgPicture.asset(
              NbSvg.calendar,
              width: 15.w,
              colorFilter:
                  const ColorFilter.mode(NbColors.black, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  void _getDataRange() async {
    final data =
        await Get.dialog<(DateTime, DateTime)>(CustomDateRangePickerDialog(
      currentDate: DateTime.now(),
      selectedRange: Get.find<ManageDataController>().dayRange.value,
    ));
    if (data != null) {
      Get.find<ManageDataController>().getPlanRange(data);
      setState(() {});
    }
  }
}

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<ManageDataController>(),
        builder: (cntr) {
          return SizedBox(
            width: double.maxFinite,
            height: 235.h,
            child: ListView.separated(
              reverse: true,
              dragStartBehavior: DragStartBehavior.down,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                double ratio = cntr.data[index].data / cntr.maxData.value;
                bool selected = cntr.data[index] == cntr.selected.value;
                return _bar(cntr.data[index].weekDay, ratio,
                    cntr.data[index].data, selected, cntr.data[index]);
              },
              separatorBuilder: (context, index) {
                return 29.horizontalSpace;
              },
              itemCount: cntr.data.length,
            ),
          );
        });
  }

  Widget _bar(
      String label, double value, double data, bool selected, DayData dayData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Get.find<ManageDataController>().selected.value = dayData;
            Get.find<ManageDataController>().update();
          },
          child: Container(
            width: 56.w,
            height: 200.h * value,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10.h, left: 5.r, right: 6.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.r),
              color:
                  selected ? NbColors.black : NbColors.black.withOpacity(0.1),
            ),
            child: NbText.sp12("${data.round()} GB").white.w500.setMaxLines(2),
          ),
        ),
        5.verticalSpace,
        NbText.sp16(label).black.w500,
      ],
    );
  }
}

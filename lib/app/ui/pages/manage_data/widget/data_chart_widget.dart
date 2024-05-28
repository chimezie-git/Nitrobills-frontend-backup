import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/custom_date_range_picker_dialog.dart';
import 'package:nitrobills/app/ui/pages/manage_data/models/chart_data.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class DataChartWidget extends StatefulWidget {
  const DataChartWidget({super.key});

  @override
  State<DataChartWidget> createState() => _DataChartWidgetState();
}

class _DataChartWidgetState extends State<DataChartWidget> {
  ChartData chartData = ChartData.sample();

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
        BarChart(
          xLabels: chartData.xLabels,
          yValues: chartData.yLabels,
        )
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
      selectedRange: chartData.dayRange,
    ));
    if (data != null) {
      chartData = ChartData(dayRange: data);
      setState(() {});
    }
  }
}

class BarChart extends StatelessWidget {
  final List<String> xLabels;
  final List<double> yValues;
  const BarChart({
    super.key,
    required this.xLabels,
    required this.yValues,
  }) : assert(yValues.length == xLabels.length);

  @override
  Widget build(BuildContext context) {
    double max =
        yValues.reduce((value, element) => value > element ? value : element);
    return SizedBox(
      width: double.maxFinite,
      height: 235.h,
      child: ListView.separated(
        reverse: true,
        dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _bar(xLabels[index], yValues[index] / max, yValues[index]);
        },
        separatorBuilder: (context, index) {
          return 29.horizontalSpace;
        },
        itemCount: xLabels.length,
      ),
    );
  }

  Widget _bar(String label, double value, double data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56.w,
          height: 200.h * value,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.r),
            color: NbColors.black,
          ),
          child: NbText.sp12("${data.round()}").white.w500.setMaxLines(1),
        ),
        5.verticalSpace,
        NbText.sp16(label).black.w500,
      ],
    );
  }
}

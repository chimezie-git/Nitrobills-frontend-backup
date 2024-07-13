import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/data/enums/weekday_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

final DateTime _oldesttimeConst = DateTime(1100);
final DateTime _faresttimeConst = DateTime(4100);

class CustomDateRangePickerDialog extends StatefulWidget {
  final DateTime currentDate;
  final DateTime? lastDate;

  /// (minDate, maxDate)
  final (DateTime, DateTime)? selectedRange;
  CustomDateRangePickerDialog({
    super.key,
    required this.currentDate,
    this.lastDate,
    this.selectedRange,
  }) : assert(currentDate.isAfter(lastDate ?? _oldesttimeConst));

  @override
  State<CustomDateRangePickerDialog> createState() =>
      _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDateRangePickerDialog> {
  late ValueNotifier<DateTime> date;
  List<(DateTime, bool)> days = [];
  final Duration _delay = const Duration(milliseconds: 500);

  DateTime? firstSelectDate;
  DateTime? lastSelectDate;

  @override
  void initState() {
    super.initState();
    firstSelectDate = widget.selectedRange?.$1;
    lastSelectDate = widget.selectedRange?.$2;
    date = ValueNotifier<DateTime>(
        DateTime(widget.currentDate.year, widget.currentDate.month));
    date.addListener(() {
      _loadDays();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadDays();
    });
  }

  _loadDays() {
    days = _monthDays();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Material(
          borderRadius: BorderRadius.circular(16.r),
          color: NbColors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 14.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _TimeButton("This week", () {}, true),
                    _TimeButton("Last week", () {}),
                    _TimeButton("This Month", () {}),
                  ],
                ),
                11.verticalSpace,
                Row(
                  children: [
                    // _DropdownButton("d", ['jan', 'feb', 'mar'], (p0) {}),
                    backButton(true),
                    const Spacer(),
                    _monthDropdown(),
                    const Spacer(),
                    _yearDropdown(),
                    const Spacer(),
                    backButton(false),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      ...WeekdayEnum.values.map(
                        (e) => Expanded(
                          child: NbText.sp16(e.name.capitalize ?? "")
                              .w600
                              .setColor(
                                const Color(0xFF929090),
                              )
                              .centerText,
                        ),
                      )
                    ],
                  ),
                ),
                11.verticalSpace,
                GridView.builder(
                  itemCount: days.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.2,
                    // crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    DateTime currDate = days[index].$1;
                    bool currMnth = days[index].$2;
                    return _dayTile(currDate, currMnth);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _yearDropdown() {
    return Container(
      width: 86.w,
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xFFECECEC),
      ),
      child: DropdownButton<int>(
          value: date.value.year,
          underline: const SizedBox.shrink(),
          icon: SvgPicture.asset(
            NbSvg.arrowDown,
            width: 13.r,
          ),
          isExpanded: true,
          items: List.generate(
            30,
            (index) => DropdownMenuItem(
              alignment: AlignmentDirectional.center,
              value: 2000 + index,
              child:
                  NbText.sp18(DateFormat('yyyy').format(DateTime(2000 + index)))
                      .w600
                      .centerText,
            ),
          ),
          onChanged: (v) {
            firstSelectDate = null;
            lastSelectDate = null;
            date.value = DateTime(v ?? date.value.year);
          }),
    );
  }

  Container _monthDropdown() {
    return Container(
      width: 86.w,
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xFFECECEC),
      ),
      child: DropdownButton<int>(
          value: date.value.month,
          underline: const SizedBox.shrink(),
          icon: SvgPicture.asset(
            NbSvg.arrowDown,
            width: 13.r,
          ),
          isExpanded: true,
          items: List.generate(
            12,
            (index) => DropdownMenuItem(
              alignment: AlignmentDirectional.center,
              value: index,
              child: NbText.sp18(DateFormat('MMM')
                      .format(DateTime(date.value.year, index + 1)))
                  .w600
                  .centerText,
            ),
          ),
          onChanged: (v) {
            firstSelectDate = null;
            lastSelectDate = null;
            date.value = DateTime(date.value.year, v ?? date.value.month);
          }),
    );
  }

  Widget _dayTile(DateTime day, bool currMnth) {
    // bool selected = sameDay(day, selectedDate ?? _oldesttimeConst);
    return InkWell(
      onTap: () {
        _select(day, currMnth);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: _borderStyle(day),
        child: Text(
          day.day.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: currMnth ? FontWeight.w600 : FontWeight.w500,
            color: currMnth ? NbColors.black : const Color(0xFF929090),
          ),
        ),
      ),
    );
  }

  void _select(DateTime day, bool currMnth) async {
    if (currMnth) {
      if (firstSelectDate != null && lastSelectDate != null) {
        firstSelectDate = day;
        lastSelectDate = null;
        setState(() {});
      } else if (firstSelectDate == null) {
        firstSelectDate = day;
        setState(() {});
      } else {
        if (day.isBefore(firstSelectDate!)) {
          lastSelectDate = firstSelectDate?.copyWith();
          firstSelectDate = day;
        } else {
          lastSelectDate = day;
        }
        setState(() {});
        await Future.delayed(_delay);
        _returnData(firstSelectDate!, lastSelectDate!);
      }
    }
  }

  void _returnData(DateTime fDay, DateTime lDay) {
    (DateTime, DateTime) result;
    if (fDay.isBefore(lDay)) {
      result = (fDay, lDay);
    } else {
      result = (lDay, fDay);
    }
    Get.back(result: result);
  }

  void _nextMonth() {
    if (date.value.month == 12) {
      date.value = DateTime(date.value.year + 1, 1);
    } else {
      date.value = DateTime(date.value.year, date.value.month + 1);
    }
  }

  void _prevMonth() {
    if (date.value.month == 1) {
      date.value = DateTime(date.value.year - 1, 12);
    } else {
      date.value = DateTime(date.value.year, date.value.month - 1);
    }
  }

  bool inRange(DateTime day) {
    return day.isAfter(firstSelectDate ?? _faresttimeConst) &&
        day.isBefore(lastSelectDate ?? _oldesttimeConst);
  }

  bool sameDay(DateTime day1, DateTime day2) {
    return (day1.day == day2.day) &&
        (day1.month == day2.month) &&
        (day1.year == day2.year);
  }

  List<(DateTime, bool)> _monthDays() {
    int monthDays = _daysMonth();
    int prevMonthDays = _prevMonthDays();
    DateTime prevMonthStartDate = _startDay();
    DateTime currentMonthStartDate = date.value;

    List<(DateTime, bool)> prevMonthData = List.generate(
      prevMonthDays,
      (index) => (prevMonthStartDate.add(Duration(days: index)), false),
    );

    List<(DateTime, bool)> currentMonthData = List.generate(
      monthDays,
      (index) {
        final dt = currentMonthStartDate.add(Duration(days: index));
        bool active = dt.isAfter(widget.lastDate ?? _oldesttimeConst);
        return (dt, active);
      },
    );

    return prevMonthData + currentMonthData;
  }

  DateTime _startDay() {
    DateTime startDate = date.value;
    return startDate.subtract(
      Duration(days: startDate.weekday - 1),
    );
  }

  int _prevMonthDays() {
    DateTime startDate = date.value;
    return startDate.weekday - 1;
  }

  int _daysMonth() {
    DateTime startDate = date.value;
    DateTime endDate;
    if (startDate.month == 12) {
      endDate = DateTime(startDate.year + 1, 1);
    } else {
      endDate = DateTime(startDate.year, startDate.month + 1);
    }

    return DateTimeRange(start: startDate, end: endDate).duration.inDays;
  }

  BoxDecoration _borderStyle(DateTime day) {
    BorderRadius? radius;
    Color? color;
    Color priColor = const Color(0xFF2BBBAD);

    if (lastSelectDate != null) {
      if (sameDay(day, firstSelectDate ?? _oldesttimeConst)) {
        radius = BorderRadius.horizontal(left: Radius.circular(24.r));
        color = priColor;
      } else if (inRange(day)) {
        radius = const BorderRadius.all(Radius.zero);
        color = priColor;
      } else if (sameDay(day, lastSelectDate ?? _oldesttimeConst)) {
        radius = BorderRadius.horizontal(right: Radius.circular(24.r));
        color = priColor;
      }
    } else {
      if (sameDay(day, firstSelectDate ?? _oldesttimeConst)) {
        radius = BorderRadius.circular(24.r);
        color = priColor;
      }
    }
    return BoxDecoration(
      color: color,
      borderRadius: radius,
    );
  }

  Widget backButton(bool back) {
    return InkWell(
      onTap: () {
        if (back) {
          _prevMonth();
        } else {
          _nextMonth();
        }
      },
      child: Container(
        width: 24.r,
        height: 24.r,
        margin: EdgeInsets.all(12.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: NbColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 2),
              blurRadius: 4,
            )
          ],
        ),
        child: RotatedBox(
          quarterTurns: back ? 1 : 3,
          child: SvgPicture.asset(
            NbSvg.arrowDown,
            width: 12.r,
            colorFilter: const ColorFilter.mode(
              NbColors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimeButton extends StatelessWidget {
  final String txt;
  final Function() onTap;
  final bool active;
  const _TimeButton(this.txt, this.onTap, [this.active = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94.w,
      height: 35.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(16.r),
        border: active ? Border.all(color: NbColors.primary) : null,
      ),
      child: NbText.sp14(txt).w500.black,
    );
  }
}

class _DropdownButton extends StatelessWidget {
  final String val;
  final void Function(String) onChange;
  final List<String> values;
  const _DropdownButton(this.val, this.values, this.onChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 86.w,
      // height: 35.h,
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButton<String>(
        items: values
            .map((e) =>
                DropdownMenuItem<String>(child: NbText.sp18(e).w500.black))
            .toList(),
        onChanged: (v) {
          if (v != null) {
            onChange(v);
          }
        },
      ),
    );
  }
}

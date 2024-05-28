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

class CustomDatePickerDialog extends StatefulWidget {
  final DateTime currentDate;
  final DateTime? lastDate;
  final DateTime? selectedDay;
  CustomDatePickerDialog({
    super.key,
    required this.currentDate,
    this.lastDate,
    this.selectedDay,
  }) : assert(currentDate.isAfter(lastDate ?? _oldesttimeConst));

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late ValueNotifier<DateTime> date;
  List<(DateTime, bool)> days = [];
  final Duration _delay = const Duration(milliseconds: 500);

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDay;
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
                Row(
                  children: [
                    backButton(true),
                    Expanded(
                        child: NbText.sp18(
                      DateFormat("MMM yyyy").format(date.value),
                    ).w600.black.centerText),
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
                    childAspectRatio: 1,
                    crossAxisSpacing: 10.w,
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

  Widget _dayTile(DateTime day, bool currMnth) {
    bool selected = sameDay(day, selectedDate ?? _oldesttimeConst);
    return InkWell(
      onTap: () {
        if (currMnth) {
          setState(() {
            selectedDate = day;
          });
          _selected(day);
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? const Color(0xFF0A6E8D) : null,
        ),
        child: Text(
          day.day.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: currMnth ? FontWeight.w600 : FontWeight.w500,
            color: currMnth
                ? (selected ? NbColors.white : NbColors.black)
                : const Color(0xFF929090),
          ),
        ),
      ),
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

  void _selected(DateTime day) async {
    await Future.delayed(_delay);
    Get.back(result: day);
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
}

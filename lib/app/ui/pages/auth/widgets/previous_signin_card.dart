import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PreviousSigninCard extends StatelessWidget {
  final DateTime? date;
  final String name;
  final void Function() onClose;

  const PreviousSigninCard(
      {super.key,
      required this.date,
      required this.name,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79.h,
      decoration: BoxDecoration(
        color: NbColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFBBB9B9),
          width: 1,
        ),
      ),
      padding: EdgeInsets.only(
        left: 16.r,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NbText.sp16(name).w500.black,
                  if (date != null)
                    NbText.sp14(
                            "Last login ${DateFormat("dd/MM/yyyy").format(date!)} ")
                        .w400
                        .setColor(const Color(0xFF929090))
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}

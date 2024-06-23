import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class EmptyFieldsWidget extends StatelessWidget {
  final String image;
  final String text;
  const EmptyFieldsWidget({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          100.verticalSpace,
          const Row(),
          Image.asset(
            image,
            width: 240.r,
            height: 240.r,
          ),
          24.verticalSpace,
          NbText.sp20(text).w500.black.centerText,
        ],
      ),
    ));
  }
}

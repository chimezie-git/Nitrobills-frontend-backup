import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class LastPaymentWidget extends StatelessWidget {
  final bool active;
  final void Function() onTap;

  const LastPaymentWidget({
    super.key,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? NbColors.white : const Color(0xFFDCDCDC),
          border: active ? Border.all(color: const Color(0xFF0A6E8D)) : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: NbText.sp16("Last payment").w500.setColor(
              active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
            ),
      ),
    );
  }
}

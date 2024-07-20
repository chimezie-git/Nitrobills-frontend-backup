import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class CopyButton extends StatefulWidget {
  final void Function() onTap;

  const CopyButton({
    super.key,
    required this.onTap,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool isLight = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () async {
        setState(() {
          isLight = false;
        });
        await Future.delayed(const Duration(milliseconds: 400));
        setState(() {
          isLight = true;
        });
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 46.h,
        width: 99.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isLight ? const Color(0xFF0A6E8D) : const Color(0xFF085067),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: NbText.sp16("Copy").w500.white,
      ),
    );
  }
}

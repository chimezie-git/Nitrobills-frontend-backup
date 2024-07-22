import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class GreyDarkGreyButton extends StatefulWidget {
  final void Function() onTap;
  final String text;

  const GreyDarkGreyButton(
      {super.key, required this.onTap, required this.text});

  @override
  State<GreyDarkGreyButton> createState() => _GreyDarkGreyButtonState();
}

class _GreyDarkGreyButtonState extends State<GreyDarkGreyButton> {
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
        height: 72.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isLight ? const Color(0xFFDDDDDD) : const Color(0xFFC1C1C1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: NbText.sp16(widget.text).w500.black,
      ),
    );
  }
}

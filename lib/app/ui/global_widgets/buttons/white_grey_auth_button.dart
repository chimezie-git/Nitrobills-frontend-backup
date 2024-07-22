import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class WhiteGreyAuthButton extends StatefulWidget {
  final void Function() onTap;
  final String text1;
  final String text2;

  const WhiteGreyAuthButton(
      {super.key,
      required this.onTap,
      required this.text1,
      required this.text2});

  @override
  State<WhiteGreyAuthButton> createState() => _WhiteGreyAuthButtonState();
}

class _WhiteGreyAuthButtonState extends State<WhiteGreyAuthButton> {
  bool isWhite = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () async {
        setState(() {
          isWhite = false;
        });
        await Future.delayed(const Duration(milliseconds: 400));
        setState(() {
          isWhite = true;
        });
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 60.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isWhite ? NbColors.white : const Color(0xFFE8E7E7),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: RichText(
          text: TextSpan(
            text: "${widget.text1} ",
            style: TextStyle(
              color: const Color(0xFF2F3336),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
            ),
            children: [
              TextSpan(
                text: "${widget.text2} ",
                style: const TextStyle(
                  color: Color(0xFF1E92E9),
                  fontFamily: 'Satoshi',
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

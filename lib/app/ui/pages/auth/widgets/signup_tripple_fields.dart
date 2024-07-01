import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class SignupTrippleFields extends StatelessWidget {
  final TextEditingController? cntrl1;
  final TextEditingController? cntrl2;
  final TextEditingController? cntrl3;
  final String? hint1;
  final String? hint2;
  final String? hint3;
  const SignupTrippleFields({
    super.key,
    this.cntrl1,
    this.cntrl2,
    this.hint1,
    this.hint2,
    this.cntrl3,
    this.hint3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 62.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            border: Border.all(
              color: const Color(0xFFBBB9B9),
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: _textField(cntrl1, hint1, TextInputType.text),
        ),
        Container(
          height: 62.h,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFBBB9B9), width: 1),
              left: BorderSide(color: Color(0xFFBBB9B9), width: 1),
              right: BorderSide(color: Color(0xFFBBB9B9), width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: _textField(cntrl2, hint2, TextInputType.phone),
        ),
        Container(
          height: 62.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
            border: const Border(
              bottom: BorderSide(color: Color(0xFFBBB9B9), width: 1),
              left: BorderSide(color: Color(0xFFBBB9B9), width: 1),
              right: BorderSide(color: Color(0xFFBBB9B9), width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: _textField(cntrl3, hint3, TextInputType.emailAddress),
        ),
      ],
    );
  }

  TextField _textField(
    TextEditingController? controller,
    String? hint,
    TextInputType? keyboardType,
  ) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: NbColors.darkGrey,
      ),
      cursorColor: NbColors.darkGrey,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF929090),
        ),
      ),
    );
  }
}

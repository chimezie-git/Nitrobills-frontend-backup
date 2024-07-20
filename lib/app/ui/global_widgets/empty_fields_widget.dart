import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class EmptyFieldsWidget extends StatelessWidget {
  final String image;
  final String text;
  final String btnText;
  final void Function() onTap;
  final String? prefix;
  final Widget? postfix;
  final void Function()? tapPostfix;
  const EmptyFieldsWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
    required this.btnText,
    this.prefix,
    this.postfix,
    this.tapPostfix,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          100.verticalSpace,
          Image.asset(
            image,
            width: 240.r,
            height: 240.r,
          ),
          24.verticalSpace,
          NbText.sp20(text).w500.black.centerText,
          70.verticalSpace,
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(30.r),
              child: Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(57.r),
                  border: Border.all(color: NbColors.primary),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefix != null) ...[
                      SvgPicture.asset(
                        prefix!,
                        height: 20.r,
                        colorFilter: const ColorFilter.mode(
                          NbColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      16.horizontalSpace,
                    ],
                    NbText.sp16(btnText).w500.primary,
                    if (postfix != null) ...[
                      8.horizontalSpace,
                      postfix!,
                    ],
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

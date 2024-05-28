import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MessagesField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  const MessagesField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: NbColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFFBBB9B9),
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: controller.text.isEmpty ? 1 : 0,
                    child: NbText.sp16("Messages").w500.black,
                  ),
                  InkWell(
                    onTap: () {
                      controller.clear();
                      onChanged("");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: SvgPicture.asset(NbSvg.clean),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: controller,
                onChanged: onChanged,
                maxLines: 6,
                cursorColor: NbColors.darkGrey,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: NbColors.darkGrey,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
        5.verticalSpace,
        NbText.sp16("${controller.text.length}/160").w500.black,
      ],
    );
  }
}

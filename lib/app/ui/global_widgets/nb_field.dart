import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/global_widgets/form_fields.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class NbField {
  static Widget text({
    TextEditingController? controller,
    double? fieldHeight,
    String? hint,
    bool obscureText = false,
    Color fieldColor = NbColors.white,
    Color borderColor = const Color(0xFFBBB9B9),
    TextInputType? keyboardType,
    bool enabled = true,
    String? Function()? validator,
    bool forcedError = false,
    String? forcedErrorString,
    void Function(String?)? onChanged,
  }) {
    return PlainTextField(
      cntrl: controller,
      hint: hint,
      keyboardType: keyboardType,
      fieldHeight: fieldHeight,
      obscureText: obscureText,
      fieldColor: fieldColor,
      enable: enabled,
      textValidator: validator ?? () => null,
      forcedError: forcedError,
      forcedErrorString: forcedErrorString,
      onChanged: onChanged,
    );
  }

  static Widget textAndIcon({
    TextEditingController? controller,
    double? fieldHeight,
    String? hint,
    Widget? trailing,
    bool obscureText = false,
    Color fieldColor = const Color.fromRGBO(255, 255, 255, 1),
    Color borderColor = const Color(0xFFBBB9B9),
    TextInputType? keyboardType,
    bool enabled = true,
    String? Function()? validator,
    bool forcedError = false,
    String? forcedErrorString,
    void Function(String?)? onChanged,
  }) {
    return IconTextField(
      cntrl: controller,
      hint: hint,
      trailing: trailing,
      keyboardType: keyboardType,
      fieldHeight: fieldHeight,
      obscureText: obscureText,
      fieldColor: fieldColor,
      enable: enabled,
      textValidator: validator ?? () => null,
      forcedError: forcedError,
      forcedErrorString: forcedErrorString,
      onChanged: onChanged,
    );
  }

  static Widget buttonArrowDown({
    required String text,
    double? fieldHeight,
    required void Function() onTap,
    String? forcedErrorString,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: fieldHeight ?? 62.h,
            decoration: BoxDecoration(
              color: NbColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: forcedErrorString == null
                    ? const Color(0xFFBBB9B9)
                    : NbColors.red,
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.r,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: NbColors.darkGrey,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  NbSvg.arrowDown,
                  width: 16.r,
                ),
              ],
            ),
          ),
        ),
        if (forcedErrorString != null)
          NbText.sp12(forcedErrorString).setColor(NbColors.red),
      ],
    );
  }

  static Widget check(
      {required bool value, required void Function(bool) onChanged}) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 32.r,
        height: 32.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: value ? const Color(0xFF505050) : null,
          border: Border.all(color: const Color(0xFF505050)),
        ),
        child: value
            ? SvgPicture.asset(
                NbSvg.check,
                width: 13.r,
                colorFilter: const ColorFilter.mode(
                  NbColors.white,
                  BlendMode.srcIn,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

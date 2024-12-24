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

  // static Widget buttonArrowDown({
  //   required String text,
  //   double? fieldHeight,
  //   required void Function() onTap,
  //   String? forcedErrorString,
  // }) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       InkWell(
  //         onTap: onTap,
  //         child: Container(
  //           alignment: Alignment.center,
  //           height: fieldHeight ?? 62.h,
  //           decoration: BoxDecoration(
  //             color: NbColors.white,
  //             borderRadius: BorderRadius.circular(16.r),
  //             border: Border.all(
  //               color: forcedErrorString == null
  //                   ? const Color(0xFFBBB9B9)
  //                   : NbColors.red,
  //               width: 1,
  //             ),
  //           ),
  //           padding: EdgeInsets.symmetric(
  //             horizontal: 16.r,
  //           ),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Text(
  //                   text,
  //                   maxLines: 1,
  //                   style: TextStyle(
  //                     fontSize: 16.sp,
  //                     fontWeight: FontWeight.w400,
  //                     color: NbColors.darkGrey,
  //                   ),
  //                 ),
  //               ),
  //               SvgPicture.asset(
  //                 NbSvg.arrowDown,
  //                 width: 16.r,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       if (forcedErrorString != null)
  //         NbText.sp12(forcedErrorString).setColor(NbColors.red),
  //     ],
  //   );
  // }

  static Widget check({
    required bool value,
    required void Function(bool) onChanged,
    double? size,
    double? radius,
    double? border,
    int? bgColor,
  }) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: size ?? 32.r,
        height: size ?? 32.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8.r),
          color: value ? Color(bgColor ?? 0xFF505050) : null,
          border: Border.all(
            color: Color(bgColor ?? 0xFF505050),
            width: border ?? 1.0,
          ),
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

class ButtonArrowDown extends StatefulWidget {
  final String text;
  final double? fieldHeight;
  final void Function() onTap;
  final String? forcedErrorString;

  const ButtonArrowDown({
    super.key,
    required this.text,
    this.fieldHeight,
    required this.onTap,
    this.forcedErrorString,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ButtonArrowDownState createState() => _ButtonArrowDownState();
}

class _ButtonArrowDownState extends State<ButtonArrowDown> {
  Color borderColor = const Color(0xFFBBB9B9); // Default border color

  void _handleTap() {
    setState(() {
      // Change the border color when tapped
      borderColor = Colors.black; // Change to your desired color
    });
    widget.onTap(); // Call the onTap function passed to the button
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _handleTap,
          child: Container(
            alignment: Alignment.center,
            height: widget.fieldHeight ?? 62.h,
            decoration: BoxDecoration(
              color: NbColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: widget.forcedErrorString == null
                    ? borderColor
                    : NbColors.red,
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.text,
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
        if (widget.forcedErrorString != null)
          NbText.sp12(widget.forcedErrorString!).setColor(NbColors.red),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class DoubleTextField extends FormField {
  static const String firstNameHint = "First name";
  static const String lastNameHint = "Last name";
  final TextEditingController firstNameCntrl;
  final TextEditingController lastNameCntrl;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  DoubleTextField({
    super.key,
    required this.firstNameCntrl,
    required this.lastNameCntrl,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  }) : super(validator: (v) {
          if (!NbValidators.isName(firstNameCntrl.text)) {
            return "Enter a valid First Name";
          }
          if (!NbValidators.isName(lastNameCntrl.text)) {
            return "Enter a valid Last Name";
          } else {
            return null;
          }
        }, builder: (FormFieldState state) {
          final Color borderColor;
          String? errorText;
          if (state.hasError || forcedError) {
            borderColor = NbColors.red;
            errorText = state.errorText ?? forcedErrorString;
          } else {
            borderColor = const Color(0xFFBBB9B9);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: _textField(
                  firstNameCntrl,
                  firstNameHint,
                  TextInputType.text,
                  onChanged: onChanged,
                ),
              ),
              Container(
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16.r)),
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: 1),
                    left: BorderSide(color: borderColor, width: 1),
                    right: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: _textField(
                  lastNameCntrl,
                  lastNameHint,
                  TextInputType.text,
                  onChanged: onChanged,
                ),
              ),
              if (errorText != null)
                NbText.sp12(errorText).setColor(borderColor),
            ],
          );
        });
}

class TrippleTextField extends FormField {
  static const String userNameHint = "Username";
  static const String emailHint = "Email address";
  static const String phoneHint = "Phone number (080-XXX-XXX-XXXX)";
  final TextEditingController userNameCntrl;
  final TextEditingController phoneNumCntrl;
  final TextEditingController emailCntrl;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  TrippleTextField({
    super.key,
    required this.userNameCntrl,
    required this.phoneNumCntrl,
    required this.emailCntrl,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  }) : super(validator: (v) {
          if (!NbValidators.isUsername(userNameCntrl.text)) {
            return "Enter a valid Username";
          } else if (!NbValidators.isPhone(phoneNumCntrl.text.trim())) {
            return "Enter a valid Phone Number";
          } else if (!NbValidators.isEmail(emailCntrl.text.trim())) {
            return "Enter a valid Email Address";
          } else {
            return null;
          }
        }, builder: (FormFieldState state) {
          final Color borderColor;
          String? errorText;
          if (state.hasError || forcedError) {
            borderColor = NbColors.red;
            errorText = state.errorText ?? forcedErrorString;
          } else {
            borderColor = const Color(0xFFBBB9B9);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: _textField(
                  userNameCntrl,
                  userNameHint,
                  TextInputType.text,
                  onChanged: onChanged,
                ),
              ),
              Container(
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: 1),
                    left: BorderSide(color: borderColor, width: 1),
                    right: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: _textField(
                  phoneNumCntrl,
                  phoneHint,
                  TextInputType.phone,
                  onChanged: onChanged,
                ),
              ),
              Container(
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16.r)),
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: 1),
                    left: BorderSide(color: borderColor, width: 1),
                    right: BorderSide(color: borderColor, width: 1),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: _textField(
                  emailCntrl,
                  emailHint,
                  TextInputType.emailAddress,
                  onChanged: onChanged,
                ),
              ),
              if (errorText != null)
                NbText.sp12(errorText).setColor(borderColor),
            ],
          );
        });
}

class PlainTextField extends FormField {
  final TextEditingController? cntrl;
  final String? hint;
  final TextInputType? keyboardType;
  final double? fieldHeight;
  final bool obscureText;
  final Color fieldColor;
  final bool enable;
  final String? Function() textValidator;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  PlainTextField({
    super.key,
    required this.cntrl,
    required this.hint,
    required this.keyboardType,
    required this.fieldHeight,
    required this.obscureText,
    required this.fieldColor,
    required this.enable,
    required this.textValidator,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  }) : super(validator: (v) {
          return textValidator();
        }, builder: (FormFieldState state) {
          final Color borderColor;
          String? errorText;
          if (state.hasError || forcedError) {
            borderColor = NbColors.red;
            errorText = state.errorText ?? forcedErrorString;
          } else {
            borderColor = const Color(0xFFBBB9B9);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: fieldHeight ?? 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: fieldColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: _textField(
                  cntrl,
                  hint,
                  keyboardType,
                  obscureText: obscureText,
                  enabled: enable,
                  onChanged: onChanged,
                ),
              ),
              if (errorText != null)
                NbText.sp12(errorText).setColor(borderColor),
            ],
          );
        });
}

class IconTextField extends FormField {
  final TextEditingController? cntrl;
  final String? hint;
  final TextInputType? keyboardType;
  final double? fieldHeight;
  final bool obscureText;
  final Color fieldColor;
  final bool enable;
  final Widget? trailing;
  final String? Function() textValidator;
  final bool forcedError;
  final String? forcedErrorString;
  final void Function(String?)? onChanged;

  IconTextField({
    super.key,
    required this.cntrl,
    required this.hint,
    required this.trailing,
    required this.keyboardType,
    required this.fieldHeight,
    required this.obscureText,
    required this.fieldColor,
    required this.enable,
    required this.textValidator,
    required this.forcedError,
    required this.forcedErrorString,
    required this.onChanged,
  }) : super(validator: (v) {
          return textValidator();
        }, builder: (FormFieldState state) {
          final Color borderColor;
          String? errorText;
          if (state.hasError || forcedError) {
            borderColor = NbColors.red;
            errorText = state.errorText ?? forcedErrorString;
          } else {
            borderColor = const Color(0xFFBBB9B9);
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: fieldHeight ?? 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: fieldColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.r,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _textField(cntrl, hint, keyboardType,
                          obscureText: obscureText,
                          enabled: enable,
                          onChanged: onChanged),
                    ),
                    trailing ?? const SizedBox.shrink(),
                  ],
                ),
              ),
              if (errorText != null)
                NbText.sp12(errorText).setColor(borderColor),
            ],
          );
        });
}

TextField _textField(
  TextEditingController? controller,
  String? hint,
  TextInputType? keyboardType, {
  bool obscureText = false,
  bool enabled = true,
  required void Function(String?)? onChanged,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    enabled: enabled,
    keyboardType: keyboardType,
    style: TextStyle(
      fontSize: 16.sp,
      height: 1,
      fontWeight: FontWeight.w500,
      color: NbColors.darkGrey,
    ),
    cursorColor: NbColors.darkGrey,
    onChanged: onChanged,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 16.sp,
        height: 1,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF929090),
      ),
    ),
  );
}

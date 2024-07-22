import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/auth/auth_service.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/big_primary_button.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPinOtpModal extends StatefulWidget {
  const VerifyPinOtpModal({
    super.key,
  });

  @override
  State<VerifyPinOtpModal> createState() => _VerifyPinOtpModalState();
}

class _VerifyPinOtpModalState extends State<VerifyPinOtpModal> {
  String otpCode = '';
  ValueNotifier<ButtonEnum> buttonStatus = ValueNotifier(ButtonEnum.disabled);
  String? otpErrorText;

  Color get fieldBorderColor =>
      otpErrorText != null ? NbColors.red : Colors.grey;

  @override
  void dispose() {
    buttonStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      color: const Color(0xFFF2F2F2),
      child: GetBuilder<UserAccountController>(
        builder: (cntrl) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              24.verticalSpace,
              NbText.sp20("Verify your OTP").w700.black,
              30.verticalSpace,
              NbText.sp16(
                      "An email with a verification code has been sent to your phone.")
                  .w500
                  .black
                  .centerText,
              32.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: PinCodeTextField(
                  scrollPadding: EdgeInsets.zero,
                  onChanged: (v) {
                    if (v.length < 6) {
                      buttonStatus.value = ButtonEnum.disabled;
                    } else {
                      buttonStatus.value = ButtonEnum.active;
                    }
                    otpCode = v;
                    _clearForcedErrors();
                  },
                  keyboardType: TextInputType.number,
                  appContext: context,
                  obscureText: true,
                  animationDuration: const Duration(milliseconds: 200),
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  blinkDuration: const Duration(milliseconds: 1200),
                  obscuringWidget: SvgPicture.asset(
                    NbSvg.obscure,
                    height: 20.r,
                  ),
                  length: 6,
                  textStyle: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2F3336),
                  ),
                  pinTheme: PinTheme(
                    fieldOuterPadding: EdgeInsets.zero,
                    selectedColor: fieldBorderColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12.r),
                    fieldHeight: 46.r,
                    fieldWidth: 46.r,
                    activeColor: fieldBorderColor,
                    inactiveFillColor: fieldBorderColor,
                    activeFillColor: fieldBorderColor,
                    inactiveColor: fieldBorderColor,
                  ),
                ),
              ),
              if (otpErrorText != null)
                NbText.sp12(otpErrorText!).setColor(fieldBorderColor),
              58.verticalSpace,
              ValueListenableBuilder(
                  valueListenable: buttonStatus,
                  builder: (context, value, child) {
                    return BigPrimaryButton(
                      status: value,
                      text: "Set new password",
                      onTap: _verifyOTPPin,
                    );
                  }),
            ]),
          );
        },
      ),
    );
  }

  void _clearForcedErrors() {
    otpErrorText = null;
    setState(() {});
  }

  void _verifyOTPPin() async {
    buttonStatus.value = ButtonEnum.loading;
    String email = Get.find<UserAccountController>().account.value.email;
    final result = await AuthService.confirmOtpPin(email, otpCode);
    buttonStatus.value = ButtonEnum.active;

    if (result.isRight) {
      Get.back(result: true);
    } else {
      if (result.left is SingleFieldError) {
        otpErrorText = result.left.message;
        setState(() {});
      } else {
        // ignore: use_build_context_synchronously
        NbToast.error(context, result.left.message);
      }
    }
  }
}

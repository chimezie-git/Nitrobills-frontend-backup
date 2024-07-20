import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/services/auth/auth_service.dart';
import 'package:nitrobills/app/ui/global_widgets/pin_code_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class ResetPinCodeModal extends StatefulWidget {
  const ResetPinCodeModal({super.key});

  @override
  State<ResetPinCodeModal> createState() => _ResetPinCodeModalState();
}

class _ResetPinCodeModalState extends State<ResetPinCodeModal> {
  ValueNotifier<ButtonEnum> btnStatus = ValueNotifier(ButtonEnum.disabled);
  bool firstPin = true;
  bool hasError = false;
  String pin1 = '';
  String pin2 = '';

  @override
  void dispose() {
    btnStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      color: NbColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          34.verticalSpace,
          NbText.sp18(firstPin ? "Enter new pin" : "Repeat pin").w700.black,
          31.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xFFE5F1F6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  NbSvg.lock,
                  width: 13.r,
                  colorFilter: const ColorFilter.mode(
                    NbColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                8.horizontalSpace,
                NbText.sp14("Secure keypad").w400.black,
              ],
            ),
          ),
          34.verticalSpace,
          if (hasError)
            NbText.sp12("Pin code is not the same").w400.setColor(NbColors.red),
          PinCodeWidget(
            onSubmit: _submit,
            spacer: 25.h,
          ),
          24.verticalSpace,
        ],
      ),
    );
  }

  void _submit(String pin) async {
    if (firstPin) {
      firstPin = false;
      hasError = false;
      pin1 = pin;
      setState(() {});
    } else {
      pin2 = pin;
      if (pin1 == pin2) {
        await setPin(pin);
      } else {
        firstPin = true;
        pin1 = '';
        pin2 = '';
        hasError = true;
        setState(() {});
      }
    }
  }

  Future setPin(String pin) async {
    btnStatus.value = ButtonEnum.loading;
    final response = await AuthService.setPin(pin: pin);
    btnStatus.value = ButtonEnum.active;
    if (response.isRight) {
      // ignore: use_build_context_synchronously
      NbToast.success(context, "Pin successfully reset");
      Get.find<UserAccountController>().account.value =
          Get.find<UserAccountController>().account.value.copy(pin: pin);
      Get.back(result: true);
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, response.left.message);
    }
  }
}

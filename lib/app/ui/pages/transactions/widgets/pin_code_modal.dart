import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/pin_code_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class PinCodeModal extends StatefulWidget {
  const PinCodeModal({super.key});

  @override
  State<PinCodeModal> createState() => _PinCodeModalState();
}

class _PinCodeModalState extends State<PinCodeModal> {
  ButtonEnum status = ButtonEnum.disabled;
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
          NbText.sp18("Enter your transaction pin").w700.black,
          32.verticalSpace,
          NbText.sp16("Forgot pin?").w700.primary,
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
          PinCodeWidget(
            onSubmit: _submit,
            spacer: 25.h,
          ),
          24.verticalSpace,
          // BlackWidgetButton(child: Row(), onTap: (){}, status: status),
          // 24.verticalSpace,
        ],
      ),
    );
  }

  void _submit(String v) {
    String pin = Get.find<UserAccountController>().account.value.pin;
    if (pin == v) {
      Get.back(result: true);
    } else {
      NbToast.error("Wrong Pin");
    }
  }
}

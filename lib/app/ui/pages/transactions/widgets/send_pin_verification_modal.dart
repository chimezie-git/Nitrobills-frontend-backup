import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/services/auth/auth_service.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/big_proceed_button.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class SendPinVerificationModal extends StatefulWidget {
  const SendPinVerificationModal({
    super.key,
  });

  @override
  State<SendPinVerificationModal> createState() =>
      _SendPinVerificationModalState();
}

class _SendPinVerificationModalState extends State<SendPinVerificationModal> {
  ValueNotifier<ButtonEnum> btnStatus = ValueNotifier(ButtonEnum.active);

  @override
  void dispose() {
    super.dispose();
    btnStatus.dispose();
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
              NbText.sp20("Verification process").w700.black,
              30.verticalSpace,
              NbText.sp18(
                      "This email address will be used to regain access to your forgotten pin.")
                  .w500
                  .black
                  .centerText,
              32.verticalSpace,
              Container(
                width: double.maxFinite,
                height: 57.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: NbColors.white,
                ),
                child: NbText.sp18(cntrl.account.value.email).w500.black,
              ),
              34.verticalSpace,
              if (!cntrl.account.value.emailVerified)
                Container(
                  width: 243.w,
                  height: 36.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: const Color(0xFFFB9E9E),
                  ),
                  child: NbText.sp18("Unverified")
                      .w500
                      .setColor(const Color(0xFFAE0505)),
                ),
              58.verticalSpace,
              ValueListenableBuilder(
                  valueListenable: btnStatus,
                  builder: (context, value, child) {
                    return BigProceedButton(
                      status: value,
                      onTap: _proceed,
                    );
                  }),
            ]),
          );
        },
      ),
    );
  }

  void _proceed() async {
    btnStatus.value = ButtonEnum.loading;
    String email = Get.find<UserAccountController>().account.value.email;
    final result = await AuthService.sendOTPEmail(email);
    btnStatus.value = ButtonEnum.active;

    if (result.isRight) {
      Get.back(result: true);
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, result.left.message);
    }
  }
}

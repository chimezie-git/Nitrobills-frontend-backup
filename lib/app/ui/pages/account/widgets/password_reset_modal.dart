import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/services/auth/auth_service.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/hive_box/auth_data/auth_data.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class PasswordResetModal extends StatefulWidget {
  const PasswordResetModal({super.key});

  @override
  State<PasswordResetModal> createState() => _PasswordResetModalState();
}

class _PasswordResetModalState extends State<PasswordResetModal> {
  late TextEditingController oldPasswordCntrl;
  late TextEditingController newPasswordCntrl;
  late TextEditingController confirmPasswordCntrl;

  bool newPasswordVisible = false;
  bool oldPasswordVisible = false;
  bool confirmPasswordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey();
  ButtonEnum btnStatus = ButtonEnum.disabled;

  @override
  void initState() {
    oldPasswordCntrl = TextEditingController(
      text: Get.find<AuthController>().password.value,
    );
    newPasswordCntrl = TextEditingController();
    confirmPasswordCntrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordCntrl.dispose();
    newPasswordCntrl.dispose();
    confirmPasswordCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      color: NbColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
        child: Form(
          key: formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            shrinkWrap: true,
            children: [
              30.verticalSpace,
              NbText.sp18("Reset Password").w600.black.centerText,
              24.verticalSpace,
              NbText.sp16("Set the new password to your account so you"
                      " can login and access all the features.")
                  .w400
                  .black,
              30.verticalSpace,
              _fieldAndLabel(
                oldPasswordCntrl,
                "Old Password",
                oldPasswordVisible,
                (v) {
                  setState(() {
                    oldPasswordVisible = v;
                  });
                },
                false,
              ),
              NbText.sp16("New Password").w600.black,
              16.verticalSpace,
              NbField.textAndIcon(
                  obscureText: true,
                  controller: newPasswordCntrl,
                  onChanged: (v) {
                    checkValidator();
                  },
                  validator: () {
                    if (!NbValidators.isPassword(newPasswordCntrl.text)) {
                      return "Password must be eight characters, with at least one letter and one number";
                    } else {
                      return null;
                    }
                  },
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        newPasswordVisible = !newPasswordVisible;
                      });
                    },
                    child: SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: SvgPicture.asset(
                        newPasswordVisible ? NbSvg.visible : NbSvg.notVisible,
                      ),
                    ),
                  )),
              30.verticalSpace,
              NbText.sp16("Confirm Password").w600.black,
              16.verticalSpace,
              NbField.textAndIcon(
                  obscureText: true,
                  onChanged: (v) {
                    checkValidator();
                  },
                  controller: confirmPasswordCntrl,
                  validator: () {
                    if (confirmPasswordCntrl.text != newPasswordCntrl.text) {
                      return "Both Passwords must be same";
                    } else {
                      return null;
                    }
                  },
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                    child: SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: SvgPicture.asset(
                        confirmPasswordVisible
                            ? NbSvg.visible
                            : NbSvg.notVisible,
                      ),
                    ),
                  )),
              30.verticalSpace,
              NbButton.primary(
                text: "Save",
                onTap: _save,
                status: btnStatus,
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Padding _fieldAndLabel(TextEditingController cntrl, String label,
      bool visible, void Function(bool) toggleView,
      [bool enabled = true]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NbText.sp16(label).w600.black,
          16.verticalSpace,
          NbField.textAndIcon(
              controller: cntrl,
              fieldColor: const Color(0xFFF2F2F2),
              borderColor: const Color(0xFFF2F2F2),
              obscureText: !visible,
              enabled: enabled,
              trailing: InkWell(
                onTap: () {
                  // toggleView(!visible);
                },
                child: SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: SvgPicture.asset(
                    visible ? NbSvg.visible : NbSvg.notVisible,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void checkValidator() {
    if (!NbValidators.isPassword(newPasswordCntrl.text)) {
      btnStatus = ButtonEnum.disabled;
    } else if (confirmPasswordCntrl.text != newPasswordCntrl.text) {
      btnStatus = ButtonEnum.disabled;
    } else {
      btnStatus = ButtonEnum.active;
    }
    setState(() {});
  }

  void _save() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      btnStatus = ButtonEnum.loading;
    });
    final passwordResult = await AuthService.changePassword(
      newPasswordCntrl.text,
    );
    setState(() {
      btnStatus = ButtonEnum.active;
    });
    if (passwordResult.isRight) {
      // ignore: use_build_context_synchronously
      NbToast.info(context, "Password Changed Successfully");
      Get.find<AuthController>().password.value = newPasswordCntrl.text;
      await AuthData.updateData(password: newPasswordCntrl.text);
      Get.back();
    } else {
      // ignore: use_build_context_synchronously
      NbToast.error(context, passwordResult.left.message);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

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

  @override
  void initState() {
    oldPasswordCntrl = TextEditingController();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            30.verticalSpace,
            NbText.sp18("Reset Password").w600.black.centerText,
            24.verticalSpace,
            NbText.sp16("Set the new password to your account so you"
                    " can login and access all the features.")
                .w400
                .black,
            30.verticalSpace,
            _fieldAndLabel(oldPasswordCntrl, "Old Password", oldPasswordVisible,
                (v) {
              setState(() {
                oldPasswordVisible = v;
              });
            }),
            _fieldAndLabel(newPasswordCntrl, "New Password", newPasswordVisible,
                (v) {
              setState(() {
                newPasswordVisible = v;
              });
            }),
            _fieldAndLabel(confirmPasswordCntrl, "Confirm Password",
                confirmPasswordVisible, (v) {
              setState(() {
                confirmPasswordVisible = v;
              });
            }),
            NbButton.primary(text: "Save", onTap: _save),
          ],
        ),
      ),
    );
  }

  Padding _fieldAndLabel(TextEditingController cntrl, String label,
      bool visible, void Function(bool) toggleView) {
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
              trailing: InkWell(
                onTap: () {
                  toggleView(!visible);
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

  void _save() {}
}

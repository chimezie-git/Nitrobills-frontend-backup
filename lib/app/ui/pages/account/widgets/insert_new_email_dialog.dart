import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class InsertNewEmailDailog extends StatefulWidget {
  const InsertNewEmailDailog({
    super.key,
  });

  @override
  State<InsertNewEmailDailog> createState() => _InsertNewEmailDailogState();
}

class _InsertNewEmailDailogState extends State<InsertNewEmailDailog> {
  TextEditingController emailCntrl = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 324.h,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 40.r,
                left: 25.w,
                right: 25.r,
                bottom: 0,
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: NbColors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      50.verticalSpace,
                      NbText.sp20("Insert New Email").w600.black,
                      18.verticalSpace,
                      NbText.sp14("Please insert your new email adress")
                          .w500
                          .setColor(const Color(0xFF4D4D4D)),
                      const Spacer(),
                      NbField.text(
                        controller: emailCntrl,
                        hint: "New email address",
                        keyboardType: TextInputType.emailAddress,
                        fieldColor: const Color(0xFFF2F2F2),
                        borderColor: const Color(0xFFF2F2F2),
                      ),
                      const Spacer(),
                      NbButton.primary(
                        text: "Change my email",
                        onTap: _changeEmail,
                        status:
                            loading ? ButtonEnum.loading : ButtonEnum.active,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Container(
                height: 66.r,
                width: 66.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFD0119B)),
                child: SvgPicture.asset(
                  NbSvg.mail,
                  width: 24.r,
                  colorFilter:
                      const ColorFilter.mode(NbColors.white, BlendMode.srcIn),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _changeEmail() async {
    if (!NbValidators.isEmail(emailCntrl.text)) {
      NbToast.error(context, "Enter a valid email address");
      return;
    }
    // Change email here
  }
}

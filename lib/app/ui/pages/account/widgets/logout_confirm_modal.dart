import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/return_home_button.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/small_outline_button.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class LogoutConfirmModal extends StatelessWidget {
  const LogoutConfirmModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 113,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: NbColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmallOutlineButton(
            onTap: () {
              Get.back();
            },
            text: "Share receipt",
          ),
          ReturnHomeButton(
            status: ButtonEnum.active,
            onTap: () {
              Get.find<AuthController>().logoutUser(context);
            },
          ),
        ],
      ),
    );
  }
}

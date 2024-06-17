import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BalanceHintWidget extends StatelessWidget {
  const BalanceHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<UserAccountController>(
      init: Get.find<UserAccountController>(),
      builder: (cntrl) {
        return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.r, vertical: 7.h),
            child: NbText.sp14("Balance: ₦ ${cntrl.balance}")
                .w500
                .setColor(const Color(0xFF8F8F8F)),
          ),
        );
      },
    );
  }
}

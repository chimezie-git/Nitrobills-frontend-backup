import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/email_info_card.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/insert_new_email_dialog.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class AccountEmailPage extends StatelessWidget {
  const AccountEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: [
              36.verticalSpace,
              NbHeader.backAndTitle(
                "Email",
                () {
                  Get.back();
                },
                fontSize: 20.w,
                fontWeight: FontWeight.w600,
                color: NbColors.black,
              ),
              37.verticalSpace,
              const Spacer(),
              EmailInfoCard(
                onTap: () {
                  Get.dialog(const InsertNewEmailDailog());
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

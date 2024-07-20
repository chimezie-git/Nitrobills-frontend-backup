import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/copy_code_field.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/referral_count_field.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/share_icon_button.dart';
import 'package:nitrobills/app/ui/utils/contact_utils/widget_to_image.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/contact_utils/nb_contact_utils.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AccountReferralPage extends StatelessWidget {
  const AccountReferralPage({super.key});

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
          child: GetX<UserAccountController>(
            init: Get.find<UserAccountController>(),
            builder: (cntrl) {
              return Column(
                children: [
                  36.verticalSpace,
                  NbHeader.backAndTitle(
                    "Refer Friend",
                    () {
                      Get.back();
                    },
                    fontSize: 20.w,
                    fontWeight: FontWeight.w600,
                    color: NbColors.black,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          20.verticalSpace,
                          NbText.sp20("Invite friends & colleagues").w500.black,
                          27.verticalSpace,
                          NbText.sp16(
                                  "Copy your code, share it with your friends Your personal code")
                              .w500
                              .black
                              .centerText,
                          39.verticalSpace,
                          CopyCodeField(
                              referralCode: cntrl.account.value.referralCode),
                          27.verticalSpace,
                          Row(
                            children: [
                              horizontalLine(),
                              36.horizontalSpace,
                              NbText.sp18("OR").w500.black,
                              36.horizontalSpace,
                              horizontalLine(),
                            ],
                          ),
                          27.verticalSpace,
                          steps(1, "Share your code to your friends."),
                          24.verticalSpace,
                          steps(2, "Your friends use your code to register."),
                          24.verticalSpace,
                          steps(3,
                              "You make N250 for every person referred that deposits at least N5000."),
                          27.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShareIconButton(
                                  svg: NbSvg.facebook, onTap: _facebook),
                              ShareIconButton(
                                  svg: NbSvg.instagram, onTap: _instagram),
                              ShareIconButton(
                                  svg: NbSvg.whatsapp, onTap: _whatsapp),
                              ShareIconButton(
                                  svg: NbSvg.twitter, onTap: _twitter),
                            ],
                          ),
                          27.verticalSpace,
                          ReferralCountField(
                              count: cntrl.account.value.referralCount),
                          100.verticalSpace,
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget horizontalLine() => Expanded(
          child: Container(
        width: double.maxFinite,
        height: 1,
        color: const Color(0xFF909090),
      ));

  Widget steps(int index, String step) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 40.r,
          height: 40.r,
          padding: EdgeInsets.all(5.r),
          decoration: const BoxDecoration(
            color: NbColors.white,
            shape: BoxShape.circle,
          ),
          child: NbText.sp18("$index").w500.black,
        ),
        12.horizontalSpace,
        Expanded(child: NbText.sp14(step).w500.black),
      ],
    );
  }

  String get _messageTxt {
    String referralCode =
        Get.find<UserAccountController>().account.value.referralCode;
    return "Use my code '$referralCode' to get a 100% bonus on your first deposit on Nitro bills";
  }

  void _facebook() {
    NbContactUtils.shareOnFacebook(_messageTxt);
  }

  void _instagram() async {
    String referralCode =
        Get.find<UserAccountController>().account.value.referralCode;
    final imageBytes = await WidgetToImage.getShareableImage(
      "Use my code ",
      referralCode,
      " to get a 100% bonus on your first deposit on Nitro bills",
    );
    await NbContactUtils.shareOnInstagram(imageBytes);
  }

  void _whatsapp() async {
    await NbContactUtils.shareOnWhatsApp(_messageTxt);
  }

  void _twitter() async {
    await NbContactUtils.shareOnTwitter(_messageTxt);
  }
}

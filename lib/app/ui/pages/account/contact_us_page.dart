import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/share_icon_button.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
              Row(children: [
                NbButton.backIcon(() {
                  Get.back();
                }),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 7.h,
                    horizontal: 23.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    color: NbColors.white,
                  ),
                  child: SvgPicture.asset(
                    NbSvg.nitrobills,
                    colorFilter: const ColorFilter.mode(
                      NbColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const Spacer(),
                24.horizontalSpace,
              ]),
              37.verticalSpace,
              NbText.sp16("App Version 0.1.0").w400.black,
              44.verticalSpace,
              Container(
                height: 125.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: NbColors.white,
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    _infoList(NbSvg.phone, "+2349163897229"),
                    const Spacer(),
                    _infoList(NbSvg.mailThick, "info@nitrobills.com"),
                    const Spacer(),
                  ],
                ),
              ),
              48.verticalSpace,
              NbText.sp16("Follow us on social networks").w500.black,
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShareIconButton(svg: NbSvg.facebook, onTap: _facebook),
                  ShareIconButton(svg: NbSvg.instagram, onTap: _instagram),
                  ShareIconButton(svg: NbSvg.whatsapp, onTap: _whatsapp),
                  ShareIconButton(svg: NbSvg.twitter, onTap: _twitter),
                ],
              ),
              27.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoList(String svg, String info) {
    return Row(
      children: [
        SizedBox(
          height: 31.r,
          width: 31.r,
          child: Center(
              child: SvgPicture.asset(
            svg,
            width: 25.r,
          )),
        ),
        12.horizontalSpace,
        Expanded(child: NbText.sp16(info).w500.black)
      ],
    );
  }

  void _facebook() {
    NbUtils.openLink(
      "https://web.facebook.com/profile.php?id=100095249647149",
      "Could not open Facebook,\nCheck your network and try Again!",
    );
  }

  void _instagram() {
    NbUtils.openLink(
      "https://www.instagram.com/nitro_bills/",
      "Could not open Instagram,\nCheck your network and try Again!",
    );
  }

  void _whatsapp() {
    NbUtils.openLink(
      "https://api.whatsapp.com/send?phone=2349163897229&text=Im%20in%20need%20of%20assistance.",
      "Could not open Whatsapp,\nCheck your network and try Again!",
    );
  }

  void _twitter() {
    NbUtils.openLink(
      "https://twitter.com/Nitrobills",
      "Could not open Twitter,\nCheck your network and try Again!",
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/contact_utils/nb_contact_utils.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ContactSupportCard extends StatelessWidget {
  const ContactSupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 178.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: NbColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NbText.sp16("Contact support").w500.black,
          const Spacer(flex: 2),
          _infoTile(NbSvg.phone, "+2349163897229", () async {
            await NbContactUtils.phoneCall("+2349163897229");
          }),
          const Spacer(),
          _infoTile(NbSvg.emailHeart, "info@nitrobills.com", () async {
            await NbContactUtils.sendEmail(toEmail: "info@nitrobills.com");
          }),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _infoTile(String svg, String info, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(child: NbText.sp14(info).w700.black),
          SvgPicture.asset(
            svg,
            width: 22.r,
            colorFilter:
                const ColorFilter.mode(NbColors.black, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/ui/pages/account/model/grouped_list_item.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/grouped_list_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.verticalSpace,
                if (!Get.find<UserAccountController>()
                    .account
                    .value
                    .emailVerified)
                  _pendingVerification(),
                NbText.sp18("Account").w500.black,
                16.verticalSpace,
                GroupedListWidget(
                  items: GroupedListItem.account(),
                ),
                18.verticalSpace,
                NbText.sp18("Security").w500.black,
                16.verticalSpace,
                GroupedListWidget(
                  items: GroupedListItem.security(),
                ),
                18.verticalSpace,
                NbText.sp18("About").w500.black,
                16.verticalSpace,
                GroupedListWidget(
                  items: GroupedListItem.about(),
                ),
                100.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pendingVerification() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 19.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: const Color(0xFFFFF1CD),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                NbSvg.mailThick,
                width: 18.w,
                colorFilter:
                    const ColorFilter.mode(Color(0xFFC7841B), BlendMode.srcIn),
              ),
              14.horizontalSpace,
              Expanded(
                child: RichText(
                  text: TextSpan(
                      children: [
                        const TextSpan(
                            text:
                                "Pending email address verification, confirm account before "),
                        TextSpan(
                            text: "24:00",
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        const TextSpan(
                            text:
                                " Hrs to be able recover your forgotten pin."),
                      ],
                      style: TextStyle(
                        color: const Color(0xFFC7841B),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              )
            ],
          ),
        ),
        22.verticalSpace,
      ],
    );
  }
}

import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/grey_dark_grey_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/home/models/bank_info.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class FundAccountPage extends StatelessWidget {
  final BankInfo bankInfo;
  const FundAccountPage({super.key, required this.bankInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                37.verticalSpace,
                NbHeader.backAndTitle(
                  "Fund Account",
                  () {
                    Get.back();
                  },
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                32.verticalSpace,
                SvgPicture.asset(
                  NbSvg.nigeriaCircle,
                  width: 64.r,
                ),
                40.verticalSpace,
                NbText.sp16(
                        "You can add funds to any of the accounts below using a bank transfer")
                    .black
                    .w500
                    .centerText,
                23.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: NbColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _bankInfo(context, "Account Name", bankInfo.accountName),
                      35.verticalSpace,
                      _bankInfo(context, "Bank Name", bankInfo.bankName),
                      35.verticalSpace,
                      _bankInfo(
                          context, "Account Number", bankInfo.accountNumber),
                    ],
                  ),
                ),
                20.verticalSpace,
                Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC1C1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NbText.sp16("N50 charge on every deposit.").w500.black,
                      10.horizontalSpace,
                      ElTooltip(
                        color: const Color(0xFFFDE8E8),
                        radius: Radius.circular(16.r),
                        position: ElTooltipPosition.rightStart,
                        content: NbText.sp14(
                                "This fixed charged is due to third-party processing fees,"
                                " service fees, maintenance fees, and a 7.5% VAT on transactions by CBN.")
                            .w400
                            .black,
                        child: Container(
                          height: 24.r,
                          width: 24.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF323232).withOpacity(0.15),
                          ),
                          child: SvgPicture.asset(NbSvg.iSvg),
                        ),
                      ),
                    ],
                  ),
                ),
                23.verticalSpace,
                GreyDarkGreyButton(
                    onTap: _shareAccount, text: "Share Account Details"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bankInfo(BuildContext context, String title, String info) {
    return InkWell(
      onTap: () async {
        ClipboardData data = ClipboardData(text: info);
        await Clipboard.setData(data);
        // ignore: use_build_context_synchronously
        NbToast.copy(context, "$title copied");
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NbText.sp16(title).w500.black,
                5.verticalSpace,
                NbText.sp16(info).w500.black,
              ],
            ),
          ),
          SvgPicture.asset(NbSvg.copy),
        ],
      ),
    );
  }

  void _shareAccount() {
    Get.back();
  }
}

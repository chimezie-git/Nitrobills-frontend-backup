import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/navbar_controller.dart';
import 'package:nitrobills/app/ui/pages/home/fund_account_page.dart';
import 'package:nitrobills/app/ui/pages/home/models/bank_info.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_contants.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class UserBanksWidget extends StatefulWidget {
  final List<BankInfo> bankData;
  const UserBanksWidget({
    super.key,
    required this.bankData,
  });

  @override
  State<UserBanksWidget> createState() => _UserBanksWidgetState();
}

class _UserBanksWidgetState extends State<UserBanksWidget> {
  late PageController controller;
  late List<BankInfo> bankList;
  final Duration duration = const Duration(milliseconds: 300);
  final Curve curve = Curves.easeIn;
  int pageIndex = 0;

  @override
  void initState() {
    controller = PageController();
    bankList = widget.bankData;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDDDBDB)),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Column(
        children: [
          Container(
            height: 46.h,
            padding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 4.w,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                    duration: duration,
                    curve: curve,
                    top: 0,
                    bottom: 0,
                    left: pageIndex == 0 ? 0 : 150.w,
                    // right: 0,
                    width: 150.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: NbColors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    )),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 0;
                          });
                          controller.animateToPage(0,
                              duration: duration, curve: curve);
                        },
                        child: _selectedText(
                            bankList.first.bankDisplayName, pageIndex == 0),
                      )),
                      10.horizontalSpace,
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                          controller.animateToPage(1,
                              duration: duration, curve: curve);
                        },
                        child: _selectedText(
                            bankList.last.bankDisplayName, pageIndex == 1),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: bankList
                .map((e) => _BankTab(
                      bankInfo: e,
                    ))
                .toList(),
          )),
        ],
      ),
    );
  }

  Widget _selectedText(String txt, bool selected) {
    return selected
        ? NbText.sp16(txt)
            .w600
            .setColor(const Color(0xFF212121))
            .centerText
            .setMaxLines(1)
        : NbText.sp16(txt)
            .w500
            .setColor(const Color(0xFF4E4747))
            .centerText
            .setMaxLines(1);
  }
}

class _BankTab extends StatelessWidget {
  final BankInfo? bankInfo;
  const _BankTab({super.key, this.bankInfo});

  @override
  Widget build(BuildContext context) {
    if (bankInfo == null) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: NbText.sp16("This Payment methodd is currently unavailable")
            .w500
            .centerText
            .setColor(const Color(0xFF090606)),
      );
    }
    return Column(
      children: [
        InkWell(
          onTap: _fundAccount,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: NbText.sp16(bankInfo?.accountName ?? "")
                          .setMaxLines(1)
                          .setColor(const Color(0xFF090606))
                          .w500,
                    ),
                    InkWell(
                      onTap: _copyBankDetails,
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Center(
                          child: SvgPicture.asset(
                            NbSvg.copy,
                            width: 18.r,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: NbText.sp16("Acct. Number")
                          .setMaxLines(1)
                          .setColor(const Color(0xFF090606))
                          .w500,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF13191B).withOpacity(0.11),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: NbText.sp16(bankInfo?.accountNumber ?? "")
                          .setColor(const Color(0xFF282828)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NbText.sp16("Your Data Balance")
                .w400
                .setColor(const Color(0xFF090606)),
            NbText.sp16("0GB/0GB").w400.setColor(const Color(0xFF090606)),
          ],
        ),
        8.verticalSpace,
        Container(
          height: 9.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        12.verticalSpace,
        Row(
          children: [
            phoneNumber("MTN 3232"),
            20.horizontalSpace,
            phoneNumber("GLO 3232"),
          ],
        ),
      ],
    );
  }

  Container phoneNumber(String name) {
    return Container(
      height: 35.h,
      width: 83.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBBB9B9)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: NbText.sp14(name).w400,
    );
  }

  void _copyBankDetails() async {
    ClipboardData data = ClipboardData(text: bankInfo!.accountNumber);
    await Clipboard.setData(data);
    NbToast.copy("account number copied");
  }

  Future _fundAccount() async {
    if (bankInfo != null) {
      NavbarController cntr = Get.find<NavbarController>();
      cntr.toggleShowTab(false);
      await Get.to(
        () => FundAccountPage(bankInfo: bankInfo!),
        transition: Transition.fadeIn,
        duration: NbContants.navDuration,
      );
      cntr.toggleShowTab(true);
    }
  }
}

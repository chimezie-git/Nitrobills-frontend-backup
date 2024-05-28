import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/models/img_txt_function.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BettingServiceProviderModal extends StatelessWidget {
  const BettingServiceProviderModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      color: NbColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 19.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp16("Service Provider").w500.black.centerText,
            23.verticalSpace,
            ...BetServiceProvider.all.map(
              (bet) => planListTile(
                ImgTextFunction(
                    image: bet.image,
                    text: bet.name,
                    onTap: () {
                      _setProvider(bet);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget planListTile(ImgTextFunction imgTxtFn) {
    return InkWell(
      onTap: imgTxtFn.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                imgTxtFn.image,
                width: 40.r,
                height: 40.r,
              ),
            ),
            13.horizontalSpace,
            NbText.sp16(imgTxtFn.text).w500.black,
          ],
        ),
      ),
    );
  }

  void _setProvider(BetServiceProvider betProvider) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Get.back(result: betProvider);
  }
}

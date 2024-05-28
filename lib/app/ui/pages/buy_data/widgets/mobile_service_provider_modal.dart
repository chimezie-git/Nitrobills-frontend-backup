import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/img_txt_function.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MobileServiceProviderModal extends StatelessWidget {
  const MobileServiceProviderModal({super.key});

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
            Row(
              children: [
                InkWell(
                  onTap: _close,
                  child: SizedBox(
                    width: 24.r,
                    height: 24.r,
                    child: Center(
                        child: SvgPicture.asset(
                      NbSvg.close,
                      width: 14.r,
                    )),
                  ),
                ),
                Expanded(
                  child: NbText.sp16("Service Provider").w500.black.centerText,
                ),
                SizedBox(width: 24.r),
              ],
            ),
            23.verticalSpace,
            ...MobileServiceProvider.all.map(
              (mobile) => planListTile(
                ImgTextFunction(
                  image: mobile.image,
                  text: mobile.name,
                  onTap: () {
                    _select(mobile);
                  },
                ),
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

  void _select(MobileServiceProvider mobileProvider) {
    Get.back(result: mobileProvider);
  }

  void _close() {
    Get.back();
  }
}

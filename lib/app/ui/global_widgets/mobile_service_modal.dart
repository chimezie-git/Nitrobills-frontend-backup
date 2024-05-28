import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/img_txt_function.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class MobileServiceModal extends StatelessWidget {
  const MobileServiceModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      color: const Color(0xFFF2F2F2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp18("Service").w600.black.centerText,
            23.verticalSpace,
            ...MobileServiceProvider.all.map(
              (elect) => planListTile(
                ImgTextFunction(
                    image: elect.image,
                    text: elect.name,
                    onTap: () {
                      _setProvider(elect);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget planListTile(ImgTextFunction imgTxtFn) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: InkWell(
        onTap: imgTxtFn.onTap,
        child: Container(
          height: 76.h,
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            color: NbColors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
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
              24.horizontalSpace,
              NbText.sp16(imgTxtFn.text).w500.black,
              const Spacer(),
              RotatedBox(
                  quarterTurns: 3,
                  child: SvgPicture.asset(
                    NbSvg.arrowDown,
                    width: 16.r,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _setProvider(MobileServiceProvider mobileService) async {
    Get.back(result: mobileService);
  }

  Future<AbstractServiceProvider?> _getService(Widget child) async {
    return Get.bottomSheet<AbstractServiceProvider>(
      child,
      barrierColor: NbColors.black.withOpacity(0.2),
      isScrollControlled: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/img_txt_function.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_airtime_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_bet_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_cable_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_data_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_electricity_service_provider_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ServiceTypeModal extends StatelessWidget {
  final bool onlyServiceType;
  const ServiceTypeModal({
    super.key,
    this.onlyServiceType = false,
  });

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
            ...ServiceTypesEnum.all.map(
              (elect) => planListTile(
                ImgTextFunction(
                    image: elect.img,
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

  void _setProvider(ServiceTypesEnum serviceType) async {
    if (onlyServiceType) {
      Get.back(result: serviceType);
    } else {
      AbstractServiceProvider? service;
      switch (serviceType) {
        case ServiceTypesEnum.airtime:
          service = await _getService(const GbAirtimeServiceProviderModal());
          break;
        case ServiceTypesEnum.data:
          service = await _getService(const GbDataServiceProviderModal());
          break;
        case ServiceTypesEnum.betting:
          service = await _getService(const GbBetServiceProviderModal());
          break;
        case ServiceTypesEnum.cable:
          service = await _getService(const GbCableServiceProviderModal());
          break;
        case ServiceTypesEnum.electricity:
          service =
              await _getService(const GbElectricityServiceProviderModal());
          break;
        default:
          throw Exception("Not available");
      }
      if (service != null) {
        Get.back(result: (serviceType, service));
      }
    }
  }

  Future<AbstractServiceProvider?> _getService(Widget child) async {
    return Get.bottomSheet<AbstractServiceProvider>(
      child,
      barrierColor: NbColors.black.withOpacity(0.2),
      isScrollControlled: true,
      isDismissible: true,
    );
  }
}

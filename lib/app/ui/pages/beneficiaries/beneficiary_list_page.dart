import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class BeneficiaryListPage extends StatelessWidget {
  final ServiceTypesEnum serviceType;
  final AbstractServiceProvider serviceProvider;
  const BeneficiaryListPage(
      {super.key, required this.serviceType, required this.serviceProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              36.verticalSpace,
              NbHeader.backAndTitle(
                "Beneficiary List",
                () {
                  Get.back();
                },
                fontSize: 18.w,
                fontWeight: FontWeight.w600,
                color: NbColors.black,
              ),
              20.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 44.h,
                decoration: BoxDecoration(
                  color: NbColors.white,
                  border: Border.all(color: const Color(0xFF0A6E8D)),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(serviceProvider.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    NbText.sp16(serviceType.shortName).w500.setColor(
                          const Color(0xFF0A6E8D),
                        ),
                    8.horizontalSpace,
                    SvgPicture.asset(
                      NbSvg.arrowDown,
                      width: 14.r,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFF0A6E8D), BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              Expanded(
                child: ListView(children: [
                  ...Get.find<BeneficiariesController>()
                      .beneficiaries
                      .where((bene) {
                    return (bene.serviceType == serviceType) &&
                        (bene.serviceProvider.name == serviceProvider.name);
                  }).mapIndexed((idx, ben) => Padding(
                            padding: EdgeInsets.only(bottom: 32.h),
                            child: _beneficiaryListTile(ben, idx),
                          )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _beneficiaryListTile(Beneficiary beneficiary, int index) {
    return InkWell(
      onTap: () {
        Get.back(result: beneficiary);
      },
      child: Container(
        height: 96.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: NbColors.white,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: NbUtils.listColor(index),
                ),
                child: NbText.sp18(beneficiary.name[0]).w600.white,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: NbText.sp18(beneficiary.name).w500.black,
            ),
          ],
        ),
      ),
    );
  }
}

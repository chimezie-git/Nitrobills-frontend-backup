import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BeneficiariesActionsModal extends StatelessWidget {
  final ServiceTypesEnum serviceType;

  const BeneficiariesActionsModal({super.key, required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NbColors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 25.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp16("Actions").w500.black,
            10.verticalSpace,
            _frequencyTile(NbSvg.send, sendName.capitalize ?? "", _send),
            _divider(),
            _frequencyTile(NbSvg.autopay, "Setup auto pay", _autopay),
            _divider(),
            _frequencyTile(NbSvg.delete, "Delete Beneficiart", _delete),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
        height: 1,
        color: const Color(0xFFBBB9B9),
      );

  Widget _frequencyTile(String svg, String txt, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          children: [
            SizedBox(
              width: 40.r,
              height: 40.r,
              child: Center(
                  child: SvgPicture.asset(
                svg,
                width: 25.r,
              )),
            ),
            13.horizontalSpace,
            Expanded(
              flex: 2,
              child: NbText.sp16(txt).w500.black,
            )
          ],
        ),
      ),
    );
  }

  void _send() async {
    Get.back(result: 1);
  }

  void _autopay() async {
    Get.back(result: 2);
  }

  void _delete() async {
    Get.back(result: 3);
  }

  String get sendName {
    if (serviceType == ServiceTypesEnum.airtime ||
        serviceType == ServiceTypesEnum.data) {
      return "Send ${serviceType.shortName}";
    } else {
      return "Pay ${serviceType.shortName}";
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/pages/transactions/widgets/avatar_selection_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class OverviewProviderTile extends StatelessWidget {
  const OverviewProviderTile({
    super.key,
    required this.bill,
    required this.colorIdx,
    required this.avatarIdx,
    required this.onSetAvatar,
  });

  final Bill bill;
  final int? colorIdx;
  final int? avatarIdx;

  /// color, index
  final void Function(int, int) onSetAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: NbColors.white,
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: InkWell(
              onTap: _chooseAvatar,
              borderRadius: BorderRadius.circular(9.6.r),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorIdx != null
                      ? Beneficiary.bgColor[colorIdx!]
                      : const Color(0xFF897AE5),
                  borderRadius: BorderRadius.circular(9.6.r),
                ),
                child: avatarIdx != null
                    ? Beneficiary.avatarImage(avatarIdx!)
                    : SvgPicture.asset(
                        NbSvg.editAvatar,
                        width: 22.r,
                        height: 22.r,
                        colorFilter: const ColorFilter.mode(
                          NbColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NbText.sp20(_name).w500,
                Row(
                  children: [
                    Container(
                      width: 25.r,
                      height: 25.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(bill.provider.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      width: 36.w,
                      height: 22.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: const Color(0xFFEAEAEA),
                      ),
                      child: NbText.sp12("ID").w500.setColor(
                            const Color(0xFFB0B0B0),
                          ),
                    ),
                    8.horizontalSpace,
                    NbText.sp14(_number).w500.black,
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _number {
    return '${bill.codeNumber.substring(0, 2)}-${bill.codeNumber.substring(2, 5)}-${bill.codeNumber.substring(5, 8)}-${bill.codeNumber.substring(8)}';
  }

  String get _name {
    if (bill.saveBeneficiary) {
      return bill.name;
    } else {
      return "${bill.provider.name} ${bill.serviceType.shortName}";
    }
  }

  void _chooseAvatar() async {
    final data = await Get.bottomSheet<(int?, int?)>(
      AvatarSelectionModal(
        avatarIdx: avatarIdx,
        colorIdx: colorIdx,
      ),
    );
    if (data != null) {
      onSetAvatar(data.$1!, data.$2!);
    }
  }
}

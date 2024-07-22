import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/hive_box/recent_payments/recent_payment.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class YourAccountsListTile extends StatelessWidget {
  final RecentPayment recentPayment;
  final MobileServiceProvider provider;
  final void Function() onTap;
  final void Function() onDelete;

  const YourAccountsListTile({
    super.key,
    required this.recentPayment,
    required this.onTap,
    required this.onDelete,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 76.h,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 2.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                height: 44.h,
                width: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(provider.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NbText.sp14(provider.name).w500.black,
                    NbText.sp14(recentPayment.number).w500.black,
                  ],
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: SvgPicture.asset(
                  NbSvg.trashCan,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

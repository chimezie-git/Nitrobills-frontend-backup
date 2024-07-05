import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/models/phone_number.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class YourAccountsListTile extends StatelessWidget {
  final PhoneNumber phoneNumber;
  final void Function() onTap;
  const YourAccountsListTile({
    super.key,
    required this.phoneNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 76.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
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
                    image: AssetImage(phoneNumber.provider.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NbText.sp14(phoneNumber.provider.name).w500.black,
                    NbText.sp14(phoneNumber.number).w500.black,
                  ],
                ),
              ),
              SvgPicture.asset(
                NbSvg.trashCan,
                width: 24.w,
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

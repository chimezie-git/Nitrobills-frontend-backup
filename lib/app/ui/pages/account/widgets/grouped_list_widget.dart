import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/ui/pages/account/model/grouped_list_item.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class GroupedListWidget extends StatelessWidget {
  final List<GroupedListItem> items;
  const GroupedListWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NbColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final groupItem = items[index];
            return groupListTile(groupItem);
          }),
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: items.map((groupItem) {
      //     return ListTile(groupItem);
      //   }).toList(),
      // ),
    );
  }

  Widget groupListTile(GroupedListItem groupItem) {
    return InkWell(
      onTap: groupItem.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 27.w,
          vertical: 20.h,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              groupItem.svg,
              width: 24.r,
              colorFilter: const ColorFilter.mode(
                NbColors.black,
                BlendMode.srcIn,
              ),
            ),
            20.horizontalSpace,
            Expanded(
                child: NbText.sp16(groupItem.name).w500.black.setMaxLines(1)),
            if (groupItem.isEmail &&
                !Get.find<UserAccountController>().account.value.emailVerified)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xFFFAD2D2),
                ),
                child: NbText.sp12("Unverified").w500.setColor(
                      const Color(0xFFD12E2E),
                    ),
              ),
            16.horizontalSpace,
            if (groupItem.arrowIcon)
              RotatedBox(
                quarterTurns: 3,
                child: SvgPicture.asset(
                  NbSvg.arrowDown,
                  width: 15.r,
                  colorFilter: const ColorFilter.mode(
                    NbColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

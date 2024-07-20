import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/hive_box/recent_payments/recent_payment.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class DeleteAccountModal extends StatefulWidget {
  final RecentPayment payment;
  const DeleteAccountModal({
    super.key,
    required this.payment,
  });

  @override
  State<DeleteAccountModal> createState() => _DeleteAccountModalState();
}

class _DeleteAccountModalState extends State<DeleteAccountModal> {
  ButtonEnum status = ButtonEnum.active;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: NbColors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp18("Delete ?").w400.black,
            32.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: NbButton.outlinedPrimary(
                      text: "Cancel",
                      onTap: () {
                        Get.back();
                      }),
                ),
                16.horizontalSpace,
                Expanded(
                  child: BlackWidgetButton(
                    onTap: _delete,
                    status: status,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NbText.sp14("Confirm").w500.white,
                        8.horizontalSpace,
                        SvgPicture.asset(
                          NbSvg.trashCan,
                          width: 18.r,
                          colorFilter: const ColorFilter.mode(
                              NbColors.white, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _delete() async {
    setState(() {
      status = ButtonEnum.loading;
    });
    await NbHiveBox.recentPayBox.delete(widget.payment.id);

    setState(() {
      status = ButtonEnum.active;
    });
    Get.back();
  }
}

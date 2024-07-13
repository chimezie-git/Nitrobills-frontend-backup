import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AvatarSelectionModal extends StatefulWidget {
  const AvatarSelectionModal({
    super.key,
    this.colorIdx,
    this.avatarIdx,
  });
  final int? colorIdx;
  final int? avatarIdx;

  @override
  State<AvatarSelectionModal> createState() => _AvatarSelectionModalState();
}

class _AvatarSelectionModalState extends State<AvatarSelectionModal> {
  late int? selectedColor;
  late int? selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.colorIdx;
    selectedAvatar = widget.avatarIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NbColors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NbText.sp18("Choose Identifier").w700.black,
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                Beneficiary.bgColor.length,
                (idx) => _colorTile(idx),
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                _avatarTile(0),
                12.horizontalSpace,
                _avatarTile(1),
                12.horizontalSpace,
                _avatarTile(2),
              ],
            ),
            24.verticalSpace,
            BlackWidgetButton(
              onTap: () {
                return Get.back(result: (selectedColor, selectedAvatar));
              },
              status: ((selectedColor != null) && (selectedAvatar != null))
                  ? ButtonEnum.active
                  : ButtonEnum.disabled,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NbText.sp16("Select").w500.white,
                  8.horizontalSpace,
                  RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      NbSvg.arrowBack,
                      width: 15.w,
                      colorFilter: const ColorFilter.mode(
                        NbColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarTile(int idx) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedAvatar = idx;
        });
      },
      child: SizedBox(
        width: 73.w,
        height: 95.h,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              width: 24.r,
              height: 24.r,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE9E6E6),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              top: 12.h,
              width: 61.w,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 61.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      color: selectedColor == null
                          ? null
                          : Beneficiary.bgColor[selectedColor!],
                    ),
                    child: Beneficiary.avatarImage(idx),
                  ),
                  const Spacer(),
                  NbText.sp12(_avatarName(idx)).w400,
                  const Spacer(),
                ],
              ),
            ),
            if (idx == selectedAvatar)
              Positioned(
                right: 0,
                top: 0,
                width: 24.r,
                height: 24.r,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF57C2FE),
                  ),
                  child: SvgPicture.asset(
                    NbSvg.check,
                    colorFilter: const ColorFilter.mode(
                      NbColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _avatarName(int idx) {
    if (idx == 0) {
      return "Initials";
    } else {
      return "Avatar $idx";
    }
  }

  Widget _colorTile(int idx) {
    return InkWell(
      borderRadius: BorderRadius.circular(9.r),
      onTap: () {
        setState(() {
          selectedColor = idx;
        });
      },
      child: Container(
        width: 61.w,
        height: 61.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: Beneficiary.bgColor[idx],
        ),
        child: Container(
          width: 24.r,
          height: 24.r,
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF2D2525).withOpacity(0.2),
          ),
          child: selectedColor == idx
              ? SvgPicture.asset(
                  NbSvg.check,
                  colorFilter: const ColorFilter.mode(
                    NbColors.white,
                    BlendMode.srcIn,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

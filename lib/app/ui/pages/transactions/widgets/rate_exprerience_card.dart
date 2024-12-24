import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class RateExprerienceCard extends StatelessWidget {
  const RateExprerienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 264.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 225.h,
            child: Container(
              decoration: BoxDecoration(
                color: NbColors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                children: [
                  38.verticalSpace,
                  NbText.sp18("How was your experience?").w700.black,
                  5.verticalSpace,
                  NbText.sp14("Give a thumb's up for a good service.")
                      .w400
                      .black,
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      likeButton(),
                      48.horizontalSpace,
                      dislikeButton(),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: _leaveReview,
                      child: NbText.sp14("Leave a review  ❤️ ").w500.primary),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.r,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 64.r,
                  height: 64.r,
                  child: Image.asset(NbImage.whiteBlackRoundLogo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget likeButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 48.r,
        height: 48.r,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color(0xFFECECEC)),
        child: Text(
          "👍",
          style: TextStyle(
            fontSize: 25.sp,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget dislikeButton() {
    return InkWell(
      onTap: () {},
      child: RotatedBox(
        quarterTurns: 2,
        child: Container(
          width: 48.r,
          height: 48.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFFECECEC)),
          child: Text(
            "👍",
            style: TextStyle(
              fontSize: 25.sp,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  void _leaveReview() {
    Get.bottomSheet(
      const _RateExperienceModal(),
      isScrollControlled: true,
      isDismissible: true,
    );
  }
}

class _RateExperienceModal extends StatefulWidget {
  const _RateExperienceModal();

  @override
  State<_RateExperienceModal> createState() => _RateExperienceModalState();
}

class _RateExperienceModalState extends State<_RateExperienceModal> {
  int ratingStars = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: NbColors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            34.verticalSpace,
            NbText.sp18("Rate your order !").w700.black,
            24.verticalSpace,
            NbText.sp16(
                    "We use this information to make sure we create a better experience for you!")
                .w400
                .black
                .centerText,
            24.verticalSpace,
            _ratingStars(),
            24.verticalSpace,
            TextField(
              // controller: controller,
              // onChanged: onChanged,
              maxLines: 5,
              cursorColor: NbColors.darkGrey,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: NbColors.black,
              ),
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: NbColors.darkGrey,
                ),
                border: _fieldBorder(),
                enabledBorder: _fieldBorder(),
                focusedBorder: _fieldBorder(),
                // contentPadding: EdgeInsets.zero,
              ),
            ),
            20.verticalSpace,
            BlackWidgetButton(
              onTap: () {},
              status: ButtonEnum.active,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NbText.sp14("Submit").w500.white,
                  8.horizontalSpace,
                  SvgPicture.asset(
                    NbSvg.send,
                    width: 18.r,
                    colorFilter:
                        const ColorFilter.mode(NbColors.white, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            NbButton.primary(
              text: "I changed my mind",
              onTap: () {},
              status: ButtonEnum.disabled,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  SizedBox _ratingStars() {
    return SizedBox(
      height: 32.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(1),
          24.horizontalSpace,
          _star(2),
          24.horizontalSpace,
          _star(3),
          24.horizontalSpace,
          _star(4),
          24.horizontalSpace,
          _star(5),
        ],
      ),
    );
  }

  Widget _star(int idx) {
    return InkWell(
        onTap: () {
          setState(() {
            ratingStars = idx;
          });
        },
        child: (ratingStars >= idx)
            ? Image.asset(NbImage.goldRatingStar)
            : Image.asset(NbImage.greyRatingStar));
  }

  OutlineInputBorder _fieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: NbColors.black));
  }
}

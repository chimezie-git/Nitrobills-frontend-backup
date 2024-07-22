import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/loaders/circle_loader.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PayNowButton extends StatefulWidget {
  final void Function() onTap;

  final ButtonEnum status;

  const PayNowButton({super.key, required this.onTap, required this.status});

  @override
  State<PayNowButton> createState() => _PayNowButtonState();
}

class _PayNowButtonState extends State<PayNowButton> {
  bool isWhite = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: widget.status.isActive
          ? () async {
              setState(() {
                isWhite = false;
              });
              await Future.delayed(const Duration(milliseconds: 400));
              setState(() {
                isWhite = true;
              });
              widget.onTap();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 56.h,
        width: 154.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.status.bgColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: widget.status.isLoading
            ? const CircleLoader()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NbText.sp14("Pay now").w500.setColor(widget.status.textColor),
                  16.horizontalSpace,
                  SvgPicture.asset(
                    NbSvg.checkRounded,
                    width: 22.r,
                    height: 22.r,
                    colorFilter: ColorFilter.mode(
                      widget.status.textColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

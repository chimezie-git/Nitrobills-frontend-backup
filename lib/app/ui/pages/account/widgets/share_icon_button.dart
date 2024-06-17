import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class ShareIconButton extends StatelessWidget {
  final String svg;
  final void Function() onTap;
  const ShareIconButton({
    super.key,
    required this.svg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 56.r,
        height: 56.r,
        decoration: const BoxDecoration(
          color: NbColors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(10.r),
        child: SvgPicture.asset(svg),
      ),
    );
  }
}

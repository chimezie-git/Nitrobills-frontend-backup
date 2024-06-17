import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:shimmer/shimmer.dart';

class BeneficiariesLoadingPage extends StatelessWidget {
  const BeneficiariesLoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color rectColor = const Color(0xFFE8E7E7);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F3),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Shimmer.fromColors(
              baseColor: const Color(0xFFE8E7E7),
              highlightColor: NbColors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    90.verticalSpace,
                    _listTile(rectColor),
                    50.verticalSpace,
                    _listTile(rectColor),
                    50.verticalSpace,
                    _listTile(rectColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _listTile(Color rectColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _rect(64.w, 64.h, 6.r, rectColor),
            20.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _rect(87.w, 22.h, 6.r, rectColor),
                20.verticalSpace,
                _rect(106.w, 22.h, 6.r, rectColor),
              ],
            )
          ],
        ),
        30.verticalSpace,
        _rect(134.w, 22.h, 6.r, rectColor),
      ],
    );
  }

  Widget _rect(double width, double height, double radius, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );
  }
}

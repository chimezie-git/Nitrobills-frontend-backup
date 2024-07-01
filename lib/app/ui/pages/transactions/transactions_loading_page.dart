import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsLoadingPage extends StatelessWidget {
  const TransactionsLoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color rectColor = const Color(0xFFE8E7E7);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F3),
      body: Shimmer.fromColors(
        baseColor: const Color(0xFFE8E7E7),
        highlightColor: NbColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              120.verticalSpace,
              _loadingTiles(rectColor),
              50.verticalSpace,
              _loadingTiles(rectColor),
              50.verticalSpace,
              _loadingTiles(rectColor),
            ],
          ),
        ),
      ),
    );
  }

  Column _loadingTiles(Color rectColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _rect(86.w, 19.h, 6.r, rectColor),
        10.verticalSpace,
        Row(
          children: [
            _rect(36.r, 36.r, 18.r, rectColor),
            10.horizontalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rect(69.w, 22.h, 6.r, rectColor),
                10.verticalSpace,
                _rect(64.w, 22.h, 6.r, rectColor),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _rect(74.w, 19.h, 6.r, rectColor),
                10.verticalSpace,
                _rect(20.r, 20.r, 10.r, rectColor),
              ],
            ),
          ],
        ),
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

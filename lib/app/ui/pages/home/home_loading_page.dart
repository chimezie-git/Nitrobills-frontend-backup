import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingPage extends StatelessWidget {
  const HomeLoadingPage({
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    73.verticalSpace,
                    Container(
                      width: double.maxFinite,
                      height: 66.h,
                      decoration: BoxDecoration(
                        // color: NbColors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _rect(141.w, 27.h, 6.r, rectColor),
                          _rect(61.w, 27.h, 6.r, rectColor),
                          _rect(27.w, 27.h, 6.r, rectColor),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Container(
                      width: double.maxFinite,
                      height: 46.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _rect(99.w, 22.h, 6.r, rectColor),
                          _rect(87.w, 22.h, 6.r, rectColor),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    _rect(double.maxFinite, 109.h, 0, rectColor),
                    20.verticalSpace,
                    _rect(double.maxFinite, 9.h, 6.r, rectColor),
                    20.verticalSpace,
                    Container(
                      width: double.maxFinite,
                      height: 46.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        children: [
                          _rect(99.w, 22.h, 6.r, rectColor),
                          20.horizontalSpace,
                          _rect(87.w, 22.h, 6.r, rectColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

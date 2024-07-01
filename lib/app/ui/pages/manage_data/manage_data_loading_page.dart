import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:shimmer/shimmer.dart';

class ManageDataLoadingPage extends StatelessWidget {
  const ManageDataLoadingPage({
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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              80.verticalSpace,
              Row(
                children: [
                  _rect(83.w, 22.h, 6.r, rectColor),
                  const Spacer(flex: 3),
                  _rect(83.w, 22.h, 6.r, rectColor),
                  const Spacer(flex: 1),
                ],
              ),
              24.verticalSpace,
              _rect(241.w, 22.h, 6.r, rectColor),
              70.verticalSpace,
              _rect(70.w, 22.h, 6.r, rectColor),
              20.verticalSpace,
              Row(
                children: [
                  10.horizontalSpace,
                  _rect(65.w, 19.h, 6.r, rectColor),
                  40.horizontalSpace,
                  _rect(65.w, 19.h, 6.r, rectColor),
                ],
              ),
              150.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _rect(56.w, 192.h, 6.r, rectColor),
                  _rect(56.w, 146.h, 6.r, rectColor),
                  _rect(56.w, 104.h, 6.r, rectColor),
                  _rect(56.w, 178.h, 6.r, rectColor),
                ],
              ),
            ],
          ),
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

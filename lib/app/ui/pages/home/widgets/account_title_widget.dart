import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AccountTitleWidget extends StatelessWidget {
  final String amount;
  final Future<void> Function() refresh;
  const AccountTitleWidget({
    super.key,
    required this.amount,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          NbText.sp18("Account Balance").w600.setColor(const Color(0xFF6B6969)),
          const Spacer(flex: 2),
          NbText.sp20(amount).w500.setColor(const Color(0xFF244047)),
          const Spacer(),
          RotatingRefreshButton(asyncFunction: refresh)
        ],
      ),
    );
  }
}

class RotatingRefreshButton extends StatefulWidget {
  final Duration duration;
  const RotatingRefreshButton({
    super.key,
    required this.asyncFunction,
    this.duration = const Duration(milliseconds: 1000),
  });

  final Future<void> Function() asyncFunction;

  @override
  State<RotatingRefreshButton> createState() => _RotatingRefreshButtonState();
}

class _RotatingRefreshButtonState extends State<RotatingRefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  bool showRefreshIcon = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    animation = Tween<double>(
      begin: 0,
      end: 12.5664, // 2Radians (360 degrees)
    ).animate(animationController);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          showRefreshIcon = false;
        });
        animationController.forward();
        await widget.asyncFunction();
        animationController.stop();
        setState(() {
          showRefreshIcon = true;
        });
      },
      child: SizedBox(
        height: 24.r,
        width: 24.r,
        child: Center(
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: animation.value,
                  child: SvgPicture.asset(
                    showRefreshIcon ? NbSvg.refresh : NbSvg.reloadRotate,
                    width: 18.r,
                  ),
                );
              }),
        ),
      ),
    );
  }
}

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class SuccessWidget extends StatefulWidget {
  final Bill bill;

  const SuccessWidget({super.key, required this.bill});

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final Duration duration = const Duration(milliseconds: 1500);
  late ConfettiController _controllerCenter;

  late final Animation resizeAnimation;
  late final Animation opacityAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    resizeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.1, end: 0.3), weight: 0.2),
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.0), weight: 0.8),
    ]).animate(controller);

    opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.2), weight: 0.2),
      TweenSequenceItem(tween: Tween(begin: 0.2, end: 1.0), weight: 0.8),
    ]).animate(controller);

    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 8),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.reset();
      controller.forward();
      _controllerCenter.play();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return SizedBox(
            // height: (177 + 200).h,
            height: (177 + (200 * resizeAnimation.value)).h,
            width: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 20.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Opacity(
                        opacity: opacityAnimation.value,
                        child: Transform.scale(
                          scale: resizeAnimation.value,
                          child: const _CheckCircle(),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _infoWidget(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    numberOfParticles: 30,
                    emissionFrequency: 0.05,
                    maximumSize: const Size(10, 10),
                    minimumSize: const Size(8, 8),
                    createParticlePath: (size) {
                      final path = Path();
                      path.addOval(
                          Rect.fromLTWH(0, 0, size.width, size.height));
                      return path;
                    },
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    // shouldLoop:
                    //     true, // start again as soon as the animation is finished
                    // colors: const [
                    //   Colors.green,
                    //   Colors.blue,
                    //   Colors.pink,
                    //   Colors.orange,
                    //   Colors.purple
                    // ], // manually specify the colors to be used
                  ),
                ),
              ],
            ),
          );
        });
  }

  Column _infoWidget() {
    return Column(children: [
      70.verticalSpace,
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 32.r,
            width: 32.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(widget.bill.provider.image),
              ),
            ),
          ),
          8.horizontalSpace,
          NbText.sp18(_planOrAmount()).w700.black,
        ],
      ),
      16.verticalSpace,
      Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: const Color(0xFFC2E8D2),
        ),
        child: NbText.sp18("Successful").w400.setColor(const Color(0xFF2E7E45)),
      ),
    ]);
  }

  String _planOrAmount() {
    if (widget.bill.serviceType == ServiceTypesEnum.data) {
      final dBill = widget.bill as DataBill;
      return dBill.plan.name;
    } else if (widget.bill.serviceType == ServiceTypesEnum.cable) {
      final cBill = widget.bill as CableBill;
      return cBill.plan.name;
    } else {
      return "₦ ${widget.bill.amount}";
    }
  }
}

class _CheckCircle extends StatelessWidget {
  const _CheckCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168.r,
      height: 168.r,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFC2E8D2),
      ),
      child: Container(
        width: 135.4.r,
        height: 135.4.r,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF20F67A),
        ),
        child: Container(
          width: 114.2.r,
          height: 114.2.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF08A54A),
          ),
          child: SvgPicture.asset(
            NbSvg.check,
            width: 49.r,
            colorFilter: const ColorFilter.mode(
              NbColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

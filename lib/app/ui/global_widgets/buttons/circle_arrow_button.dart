import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/global_widgets/loaders/circle_loader.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class CircleArrowButton extends StatefulWidget {
  final void Function() onTap;
  final ButtonEnum status;

  const CircleArrowButton({
    super.key,
    required this.onTap,
    required this.status,
  });

  @override
  State<CircleArrowButton> createState() => _CircleArrowButtonState();
}

class _CircleArrowButtonState extends State<CircleArrowButton> {
  bool isLight = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: widget.status.isActive
          ? () async {
              setState(() {
                isLight = false;
              });
              await Future.delayed(const Duration(milliseconds: 400));
              setState(() {
                isLight = true;
              });
              widget.onTap();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50.r,
        width: 50.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isLight ? const Color(0xFF0A6E8D) : const Color(0xFF085067),
          shape: BoxShape.circle,
        ),
        child: widget.status.isLoading
            ? const CircleLoader()
            : RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  NbSvg.arrowBack,
                  colorFilter: ColorFilter.mode(
                      widget.status.textColor, BlendMode.srcIn),
                ),
              ),
      ),
    );
  }
}

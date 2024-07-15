import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

class PinCodeWidget extends StatefulWidget {
  final double? spacer;
  final void Function(String) onSubmit;
  final Duration duration;
  final ValueNotifier<ButtonEnum>? status;

  const PinCodeWidget({
    super.key,
    this.spacer,
    required this.onSubmit,
    this.duration = const Duration(milliseconds: 600),
    this.status,
  });

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  late List<String> code = [];
  late bool hide1 = false;
  late bool hide2 = false;
  late bool hide3 = false;
  late bool hide4 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PincodeField(
              text: code.isNotEmpty ? code[0] : null,
              hide: (code.length > 1) || hide1,
            ),
            24.horizontalSpace,
            _PincodeField(
              text: code.length >= 2 ? code[1] : null,
              hide: (code.length > 2) || hide2,
            ),
            24.horizontalSpace,
            _PincodeField(
              text: code.length >= 3 ? code[2] : null,
              hide: (code.length > 3) || hide3,
            ),
            24.horizontalSpace,
            _PincodeField(
              text: code.length >= 4 ? code[3] : null,
              hide: (code.length > 4) || hide4,
            ),
          ],
        ),
        SizedBox(
          height: widget.spacer ?? 112.h,
        ),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 46.w,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 60.r,
            mainAxisSpacing: 40.r,
          ),
          children: [
            _ButtonWidget(1, code.length, _onTap),
            _ButtonWidget(2, code.length, _onTap),
            _ButtonWidget(3, code.length, _onTap),
            _ButtonWidget(4, code.length, _onTap),
            _ButtonWidget(5, code.length, _onTap),
            _ButtonWidget(6, code.length, _onTap),
            _ButtonWidget(7, code.length, _onTap),
            _ButtonWidget(8, code.length, _onTap),
            _ButtonWidget(9, code.length, _onTap),
            _ButtonWidget(-1, code.length, _onTap),
            _ButtonWidget(0, code.length, _onTap),
            _ButtonWidget(-2, code.length, _onTap, widget.status),
          ],
        )
      ],
    );
  }

  void _onTap(int index) async {
    if (index == -1) {
      if (code.isNotEmpty) {
        code.removeLast();
        hide(code.length);
      }
    } else if (index == -2) {
      if (code.length == 4) {
        widget.onSubmit(code.join(""));
        _clear();
      }
    } else if (code.length < 4) {
      code.add("$index");
      setState(() {});
      await Future.delayed(widget.duration);
      hide(code.length);
    }
  }

  void hide(int index) {
    hide1 = false;
    hide2 = false;
    hide3 = false;
    hide4 = false;
    switch (index) {
      case 4:
        hide4 = true;
      case 3:
        hide3 = true;
      case 2:
        hide2 = true;
      case 1:
        hide1 = true;
      default:
    }
    setState(() {});
  }

  void _clear() {
    code = [];
    hide1 = false;
    hide2 = false;
    hide3 = false;
    hide4 = false;
    setState(() {});
  }
}

class _PincodeField extends StatelessWidget {
  final String? text;
  final bool hide;
  const _PincodeField({required this.text, required this.hide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.r,
      height: 50.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: NbColors.black),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: _child(),
    );
  }

  Widget _child() {
    if ((text == null) || hide) {
      return SvgPicture.asset(
        NbSvg.obscure,
        height: 15.r,
        width: 15.r,
        colorFilter: ColorFilter.mode(
          hide ? NbColors.black : const Color(0xFF6D6D6D).withOpacity(0.5),
          BlendMode.srcIn,
        ),
      );
    } else {
      return Text(
        text ?? "",
        style: TextStyle(
          fontSize: 16.7.sp,
          fontWeight: FontWeight.w800,
          color: NbColors.black,
        ),
      );
    }
  }
}

class _ButtonWidget extends StatelessWidget {
  final int number;
  final void Function(int) onTap;
  final ValueNotifier<ButtonEnum>? status;
  final int codeLength;
  const _ButtonWidget(this.number, this.codeLength, this.onTap, [this.status]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(number);
      },
      borderRadius: BorderRadius.circular(50.r),
      overlayColor: const WidgetStatePropertyAll(Color(0xFFD1D1D1)),
      splashFactory: InkRipple.splashFactory,
      child: Container(
        width: 50.r,
        height: 50.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: number == -2
              ? (codeLength < 4 ? const Color(0xFF6D6D6D) : NbColors.primary)
              : null,
        ),
        child: child(),
      ),
    );
  }

  Widget child() {
    if (number == -1) {
      return SvgPicture.asset(
        NbSvg.backspace,
        height: 22.r,
        width: 22.r,
        colorFilter: const ColorFilter.mode(
          NbColors.black,
          BlendMode.srcIn,
        ),
      );
    } else if (number == -2) {
      if (status == null) {
        return RotatedBox(
          quarterTurns: 2,
          child: SvgPicture.asset(
            NbSvg.arrowBack,
            height: 16.r,
            width: 16.r,
            colorFilter: const ColorFilter.mode(
              NbColors.white,
              BlendMode.srcIn,
            ),
          ),
        );
      }
      return ValueListenableBuilder(
          valueListenable: status!,
          builder: (context, value, child) {
            return value.isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      color: NbColors.white,
                      strokeCap: StrokeCap.round,
                    ),
                  )
                : RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      NbSvg.arrowBack,
                      height: 16.r,
                      width: 16.r,
                      colorFilter: const ColorFilter.mode(
                        NbColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
          });
    } else {
      return Text(
        "$number",
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }
}

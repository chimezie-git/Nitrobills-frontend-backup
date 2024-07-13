import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/repository/auth_repo.dart';
import 'package:nitrobills/app/ui/global_widgets/pin_code_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  ValueNotifier<ButtonEnum> btnStatus = ValueNotifier(ButtonEnum.disabled);
  bool firstPin = true;
  String pin1 = '';
  String pin2 = '';

  @override
  void dispose() {
    btnStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            36.verticalSpace,
            NbText.sp20("Create transaction pin").w700.black,
            25.verticalSpace,
            firstPin
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NbText.sp16("Enter your pin")
                          .w700
                          .setColor(const Color(0xFF212121)),
                      8.horizontalSpace,
                      SvgPicture.asset(
                        NbSvg.lock,
                      )
                    ],
                  )
                : NbText.sp16("Repeat your pin")
                    .w700
                    .setColor(const Color(0xFF219FFB)),
            const Spacer(),
            PinCodeWidget(
              onSubmit: (v) {
                submit(v);
              },
              status: btnStatus,
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future submit(String pin) async {
    if (firstPin) {
      firstPin = false;
      pin1 = pin;
    } else {
      pin2 = pin;
      if (pin1 == pin2) {
        await setPin(pin);
      } else {
        firstPin = true;
        pin1 = '';
        pin2 = '';
        setState(() {});
      }
    }
  }

  Future setPin(String pin) async {
    btnStatus.value = ButtonEnum.loading;
    await AuthRepo().setPin(pin);
    btnStatus.value = ButtonEnum.active;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class ChooseContactButton extends StatelessWidget {
  final void Function(String) getContact;
  const ChooseContactButton({
    super.key,
    required this.getContact,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          try {
            PhoneContact contact = await FlutterContactPicker.pickPhoneContact(
                askForPermission: true);
            String phone = contact.phoneNumber?.number ?? "";
            getContact(phone.replaceAll(" ", ""));
          } catch (e) {
            NbToast.info("Could not pick Contact");
            debugPrint(e.toString());
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.r, vertical: 7.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NbText.sp14("Choose contact")
                  .w600
                  .setColor(const Color(0xFF0A6E8D)),
              8.horizontalSpace,
              SvgPicture.asset(
                NbSvg.contacts,
                height: 18.r,
                colorFilter:
                    const ColorFilter.mode(Color(0xFF0A6E8D), BlendMode.srcIn),
              )
            ],
          ),
        ),
      ),
    );
  }
}

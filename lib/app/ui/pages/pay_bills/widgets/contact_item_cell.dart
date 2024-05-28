import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/models/contact_number.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ContactItemCell extends StatelessWidget {
  final ContactNumber contact;
  final void Function() onTap;

  const ContactItemCell({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: NbText.sp16(contact.name[0]).w500.white,
              ),
            ),
          ),
          NbText.sp16(contact.shortNum).w500.black
        ],
      ),
    );
  }
}

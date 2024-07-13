import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/hive_box/recent_payments/recent_payment.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ContactItemCell extends StatelessWidget {
  final RecentPayment payment;
  final void Function() onTap;

  const ContactItemCell({
    super.key,
    required this.payment,
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
                child: NbText.sp16(name).w500.white,
              ),
            ),
          ),
          NbText.sp16(shortNum).w500.black
        ],
      ),
    );
  }

  String get name {
    if (payment.name.isEmpty) {
      return payment.serviceProvider[0];
    } else {
      return payment.name[0];
    }
  }

  String get shortNum {
    int numLen = payment.number.length;
    return "***${payment.number.substring(numLen - 4)}";
  }
}

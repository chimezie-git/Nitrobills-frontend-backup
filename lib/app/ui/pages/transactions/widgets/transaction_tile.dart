import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/data/services/formatter.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/transaction.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  const TransactionTile({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xFFFAFAFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NbText.sp14(DateFormat("MMM, dd yyyy").format(transaction.date))
              .w500
              .setColor(const Color(0xFF5A5959)),
          6.verticalSpace,
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(transaction.iconImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NbText.sp16(transaction.transactionType.displayName)
                        .w600
                        .black,
                    const Spacer(),
                    NbText.sp14(DateFormat("hh:mm a").format(transaction.date))
                        .w500
                        .setColor(const Color(0xFF5A5959)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    NbText.sp14(
                            "${transaction.isCredit ? '+' : '-'}₦ ${NbFormatter.amount(transaction.amount)}")
                        .w500
                        .black,
                    const Spacer(),
                    Container(
                      width: 20.r,
                      height: 20.r,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: transaction.isCredit
                              ? const Color(0xFF46D26E)
                              : const Color(0xFFD25746)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

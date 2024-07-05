import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/pages/account/model/grouped_list_item.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/grouped_list_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.verticalSpace,
                NbText.sp18("Account").w500.black,
                16.verticalSpace,
                GroupedListWidget(
                  items: GroupedListItem.account(),
                ),
                18.verticalSpace,
                NbText.sp18("Security").w500.black,
                16.verticalSpace,
                GroupedListWidget(
                  items: GroupedListItem.security(),
                ),
                18.verticalSpace,
                NbText.sp18("About").w500.black,
                16.verticalSpace,
                GroupedListWidget(
                  items: GroupedListItem.about(),
                ),
                100.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

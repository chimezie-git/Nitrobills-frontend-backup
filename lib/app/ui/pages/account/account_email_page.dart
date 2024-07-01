import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/email_info_card.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/email_verification_sent_dialog.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/insert_new_email_dialog.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class AccountEmailPage extends StatefulWidget {
  const AccountEmailPage({super.key});

  @override
  State<AccountEmailPage> createState() => _AccountEmailPageState();
}

class _AccountEmailPageState extends State<AccountEmailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshData();
    });
  }

  Future _refreshData() async {
    // await FirebaseAuth.instance.currentUser?.reload();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            children: [
              36.verticalSpace,
              NbHeader.backAndTitle(
                "Email",
                () {
                  Get.back();
                },
                fontSize: 20.w,
                fontWeight: FontWeight.w600,
                color: NbColors.black,
              ),
              37.verticalSpace,
              const Spacer(),
              EmailInfoCard(
                onTap: () async {
                  // if (FirebaseAuth.instance.currentUser?.emailVerified ??
                  //     false) {
                  //   Get.dialog(const InsertNewEmailDailog());
                  // } else {
                  //   await verifyEmail();
                  // }
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Future verifyEmail() async {
    // try {
    //   await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    //   Get.dialog(const EmailVerificationSentDialog());
    // } on FirebaseException catch (e) {
    //   NbToast.error(e.message ?? "");
    // } catch (e) {
    //   NbToast.error(e.toString());
    // }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/controllers/auth/auth_controller.dart';
import 'package:nitrobills/app/ui/pages/account/account_email_page.dart';
import 'package:nitrobills/app/ui/pages/account/account_referral_page.dart';
import 'package:nitrobills/app/ui/pages/account/contact_us_page.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/password_reset_modal.dart';
import 'package:nitrobills/app/ui/pages/autopayments/manage_autopayments_page.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class GroupedListItem {
  final String name;
  final String svg;
  final void Function()? onTap;
  final bool arrowIcon;

  GroupedListItem(
      {required this.name,
      required this.svg,
      this.onTap,
      this.arrowIcon = false});

  static List<GroupedListItem> account = [
    GroupedListItem(
        name:
            "${Get.find<UserAccountController>().account.value.firstName} ${Get.find<UserAccountController>().account.value.lastName}",
        svg: NbSvg.account),
    GroupedListItem(
        name: Get.find<UserAccountController>().account.value.username,
        svg: NbSvg.username),
    GroupedListItem(
        name: "Manage auto payments",
        svg: NbSvg.manageAutopay,
        onTap: () async {
          NbUtils.removeNav;
          await NbUtils.nav.currentState?.push(MaterialPageRoute(
              builder: (context) => const ManageAutopaymentsPage()));
          NbUtils.showNav;
        }),
    GroupedListItem(
        name: Get.find<UserAccountController>().account.value.email,
        svg: NbSvg.mail,
        onTap: () async {
          NbUtils.removeNav;
          await NbUtils.nav.currentState?.push(MaterialPageRoute(
              builder: (context) => const AccountEmailPage()));
          NbUtils.showNav;
        },
        arrowIcon: true),
    GroupedListItem(
        name: _formatPhone(
            Get.find<UserAccountController>().account.value.phoneNumber),
        svg: NbSvg.phone,
        arrowIcon: false),
    GroupedListItem(
        name: "My Referrals",
        svg: NbSvg.refer,
        onTap: () async {
          NbUtils.removeNav;
          await NbUtils.nav.currentState?.push(MaterialPageRoute(
              builder: (context) => const AccountReferralPage()));
          NbUtils.showNav;
        },
        arrowIcon: true),
  ];
  static List<GroupedListItem> security = [
    GroupedListItem(
        name: "Change password",
        svg: NbSvg.password,
        onTap: () async {
          NbUtils.removeNav;
          await showModalBottomSheet(
            context: NbUtils.nav.currentContext!,
            builder: (context) => const PasswordResetModal(),
            backgroundColor: NbColors.black.withOpacity(0.2),
            isScrollControlled: true,
          );
          NbUtils.showNav;
        }),
    GroupedListItem(
        name: "Sign out",
        svg: NbSvg.signout,
        onTap: () {
          Get.find<AuthController>().logoutUser();
        }),
  ];
  static List<GroupedListItem> about = [
    GroupedListItem(
        name: "Contact Us",
        svg: NbSvg.contactUs,
        onTap: () async {
          NbUtils.removeNav;
          await NbUtils.nav.currentState?.push(
              MaterialPageRoute(builder: (context) => const ContactUsPage()));
          NbUtils.showNav;
        }),
  ];
}

String _formatPhone(String phoneNumber) {
  String phone = phoneNumber.replaceAll("+234", "0");
  return '${phone.substring(0, 3)}-${phone.substring(3, 6)}-${phone.substring(6, 9)}-${phone.substring(9)}';
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/pages/account/account_email_page.dart';
import 'package:nitrobills/app/ui/pages/account/account_referral_page.dart';
import 'package:nitrobills/app/ui/pages/account/contact_us_page.dart';
import 'package:nitrobills/app/ui/pages/account/widgets/password_reset_modal.dart';
import 'package:nitrobills/app/ui/pages/autopayments/manage_autopayments_page.dart';
import 'package:nitrobills/app/ui/pages/onboarding/intro_page.dart';
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
    GroupedListItem(name: "Alex Natan", svg: NbSvg.account),
    GroupedListItem(name: "Username", svg: NbSvg.username),
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
        name: "mail@mail.com",
        svg: NbSvg.mailThick,
        onTap: () async {
          NbUtils.removeNav;
          await NbUtils.nav.currentState?.push(MaterialPageRoute(
              builder: (context) => const AccountEmailPage()));
          NbUtils.showNav;
        },
        arrowIcon: true),
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
          NbUtils.removeNav;
          Get.offAll(() => const IntroPage());
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/contact_number.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/widgets/airtime_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/widgets/contact_item_cell.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_contants.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PayAirtimePage extends StatefulWidget {
  const PayAirtimePage({super.key});

  @override
  State<PayAirtimePage> createState() => _PayAirtimePageState();
}

class _PayAirtimePageState extends State<PayAirtimePage> {
  List<int> amounts = [100, 200, 500, 1000, 2000, 3000];

  int? amount;
  MobileServiceProvider? mobileProvider;

  late TextEditingController amountCntr;
  late TextEditingController numberCntr;

  @override
  void initState() {
    amountCntr = TextEditingController();
    numberCntr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountCntr.dispose();
    numberCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                36.verticalSpace,
                NbHeader.backAndTitle(
                  "Airtime",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                29.verticalSpace,
                NbText.sp16("Most recent").w500.black,
                15.verticalSpace,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ContactNumber.sample.length, //recentNums.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 24.w,
                    mainAxisSpacing: 20.h,
                  ),
                  itemBuilder: (context, index) {
                    ContactNumber contact = ContactNumber.sample[index];
                    return ContactItemCell(
                      contact: contact,
                      onTap: () {
                        _setContact(contact);
                      },
                    );
                  },
                ),
                24.verticalSpace,
                NbText.sp16("Choose an amount").w500.black,
                24.verticalSpace,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: amounts.length, //recentNums.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    int curAmount = amounts[index];
                    return InkWell(
                      onTap: () {
                        amountCntr.text = curAmount.toString();
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: NbColors.white,
                        ),
                        child: NbText.sp16("N$curAmount").w500.black,
                      ),
                    );
                  },
                ),
                32.verticalSpace,
                NbField.buttonArrowDown(
                  text: mobileProvider?.name ?? "Service Provider",
                  fieldHeight: 78.h,
                  onTap: _setServiceProvider,
                ),
                32.verticalSpace,
                NbField.text(
                  controller: amountCntr,
                  fieldHeight: 78.h,
                  hint: "Amount",
                ),
                32.verticalSpace,
                NbField.text(
                  controller: numberCntr,
                  fieldHeight: 78.h,
                  hint: "Phone number",
                ),
                40.verticalSpace,
                NbButton.primary(text: "Continue", onTap: _continue),
                40.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setServiceProvider() async {
    mobileProvider = await Get.bottomSheet<MobileServiceProvider>(
          const AirtimeServiceProviderModal(),
          exitBottomSheetDuration: NbContants.navDuration,
          enterBottomSheetDuration: NbContants.navDuration,
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        mobileProvider;
    setState(() {});
  }

  void _setContact(ContactNumber contact) {
    numberCntr.text = contact.number;
    mobileProvider = contact.provider;
    setState(() {});
  }

  void _continue() {
    Get.to(
      () => ConfirmTransactionScreen(
        transaction: Transaction.sampleMobile,
      ),
    );
  }
}

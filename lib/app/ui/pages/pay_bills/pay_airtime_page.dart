import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/hive_box/recent_payments/recent_payment.dart';
import 'package:nitrobills/app/ui/global_widgets/balance_hint_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/big_primary_button.dart';
import 'package:nitrobills/app/ui/global_widgets/choose_contact_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_airtime_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/widgets/contact_item_cell.dart';
import 'package:nitrobills/app/ui/pages/transactions/transaction_overview_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_contants.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';
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
  late TextEditingController nameCntr;

  GlobalKey<FormState> formKey = GlobalKey();
  String? providerValidator;
  ButtonEnum btnStatus = ButtonEnum.disabled;
  bool addToBeneficiary = false;

  @override
  void initState() {
    amountCntr = TextEditingController();
    numberCntr = TextEditingController();
    nameCntr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    amountCntr.dispose();
    numberCntr.dispose();
    nameCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Form(
            key: formKey,
            child: Column(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: NbHiveBox.recentPayBox.listenable(),
                          builder: (context, value, child) {
                            List<RecentPayment> recent = NbHiveBox
                                .recentPayBox.values
                                .where((pay) =>
                                    pay.serviceTypesEnum ==
                                    ServiceTypesEnum.airtime)
                                .toList();
                            if (recent.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            if (recent.length > 8) {
                              recent = recent.sublist(8 - recent.length);
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                29.verticalSpace,
                                NbText.sp16("Most recent").w500.black,
                                15.verticalSpace,
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: recent.length, //recentNums.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 0.67,
                                    crossAxisSpacing: 24.w,
                                    mainAxisSpacing: 20.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    final rItem = recent[index];
                                    return ContactItemCell(
                                      payment: rItem,
                                      onTap: () {
                                        _setContact(rItem);
                                      },
                                    );
                                  },
                                ),
                              ],
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemBuilder: (context, index) {
                            int curAmount = amounts[index];
                            bool selected =
                                curAmount.toString() == amountCntr.text;
                            return InkWell(
                              onTap: () {
                                amountCntr.text = curAmount.toString();
                                setState(() {});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: selected
                                      ? Border.all(color: NbColors.primary)
                                      : null,
                                  color: NbColors.white,
                                ),
                                child: NbText.sp16("₦ $curAmount")
                                    .w500
                                    .setColor(selected
                                        ? NbColors.primary
                                        : NbColors.black),
                              ),
                            );
                          },
                        ),
                        32.verticalSpace,
                        ButtonArrowDown(
                          text: mobileProvider?.name ?? "Service Provider",
                          fieldHeight: 78.h,
                          onTap: _setServiceProvider,
                          forcedErrorString: providerValidator,
                        ),
                        const BalanceHintWidget(),
                        NbField.text(
                          controller: amountCntr,
                          fieldHeight: 78.h,
                          hint: "Amount",
                          keyboardType: TextInputType.number,
                          onChanged: buttonValidate,
                          validator: () {
                            double? amount = double.tryParse(amountCntr.text);
                            if (amount == null) {
                              return "Enter a valid number";
                            } else if (mobileProvider == null) {
                              return null;
                            } else if (amount <= mobileProvider!.minAmount) {
                              return mobileProvider!.airtimeError;
                            }
                            return null;
                          },
                        ),
                        ChooseContactButton(getContact: _setPhoneNumber),
                        NbField.text(
                          controller: numberCntr,
                          fieldHeight: 78.h,
                          hint: "Phone number",
                          keyboardType: TextInputType.number,
                          onChanged: buttonValidate,
                          validator: () {
                            if (!NbValidators.isPhone(numberCntr.text)) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                        if (addToBeneficiary) ...[
                          34.verticalSpace,
                          NbField.text(
                            controller: nameCntr,
                            hint: "Name",
                            fieldHeight: 78.h,
                            onChanged: buttonValidate,
                            validator: () {
                              if (!NbValidators.isUsername(nameCntr.text)) {
                                return "Enter a valid name";
                              }
                              return null;
                            },
                          )
                        ],
                        21.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child:
                                  NbText.sp16("Add this account to beneficiary")
                                      .w500
                                      .black,
                            ),
                            NbField.check(
                              value: addToBeneficiary,
                              onChanged: (v) {
                                setState(() {
                                  addToBeneficiary = v;
                                });
                              },
                            ),
                          ],
                        ),
                        40.verticalSpace,
                      ],
                    ),
                  ),
                ),
                BigPrimaryButton(
                    status: btnStatus, text: "Continue", onTap: _continue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setServiceProvider() async {
    mobileProvider = await Get.bottomSheet<MobileServiceProvider>(
          const GbAirtimeServiceProviderModal(),
          exitBottomSheetDuration: NbContants.navDuration,
          enterBottomSheetDuration: NbContants.navDuration,
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
          isDismissible: true,
        ) ??
        mobileProvider;
    buttonValidate("val");
  }

  void _setContact(RecentPayment payment) {
    numberCntr.text = payment.number;
    final mobileProv =
        MobileServiceProvider.allDataMap[payment.serviceProvider];
    mobileProvider = mobileProv;
    buttonValidate("val");
  }

  bool get isValid {
    bool validForm = true;
    validForm = formKey.currentState?.validate() ?? false;
    if (mobileProvider == null) {
      providerValidator = "Select an Airtime Provider";
      validForm = false;
    }
    setState(() {});
    return validForm;
  }

  void buttonValidate(String? val) {
    bool isValid;
    double? amount = double.tryParse(amountCntr.text);

    if ((addToBeneficiary) && (!NbValidators.isName(nameCntr.text))) {
      isValid = false;
    } else if (!NbValidators.isPhone(numberCntr.text)) {
      isValid = false;
    } else if (mobileProvider == null) {
      isValid = false;
    } else if (amount == null || amount <= 0) {
      isValid = false;
    } else {
      isValid = true;
    }
    if (isValid) {
      btnStatus = ButtonEnum.active;
    } else {
      btnStatus = ButtonEnum.disabled;
    }
    setState(() {});
  }

  void _continue() async {
    if (isValid) {
      setState(() {
        btnStatus = ButtonEnum.loading;
      });
      AirtimeBill bill = AirtimeBill(
        amount: double.parse(amountCntr.text),
        name: '',
        codeNumber: numberCntr.text,
        provider: mobileProvider!,
        saveBeneficiary: false,
      );
      setState(() {
        btnStatus = ButtonEnum.active;
      });
      Get.to(
        () => ConfirmTransactionScreen(bill: bill),
      );
    }
  }

  void _setPhoneNumber(String contact) {
    numberCntr.text = contact;
    setState(() {});
  }
}

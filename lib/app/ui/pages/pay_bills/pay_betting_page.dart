import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/balance_hint_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/buttons/big_primary_button.dart';
import 'package:nitrobills/app/ui/global_widgets/choose_contact_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_bet_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/transaction_overview_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PayBettingPage extends StatefulWidget {
  const PayBettingPage({super.key});

  @override
  State<PayBettingPage> createState() => _PayBettingPageState();
}

class _PayBettingPageState extends State<PayBettingPage> {
  bool addToBeneficiary = false;

  late final TextEditingController idCntr;
  late final TextEditingController amountCntr;
  late final TextEditingController nameCntr;
  BetServiceProvider? betProvider;

  GlobalKey<FormState> formKey = GlobalKey();
  String? providerValidator;
  ButtonEnum btnStatus = ButtonEnum.disabled;

  @override
  void initState() {
    super.initState();
    idCntr = TextEditingController();
    amountCntr = TextEditingController();
    nameCntr = TextEditingController();
  }

  @override
  void dispose() {
    idCntr.dispose();
    amountCntr.dispose();
    nameCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      resizeToAvoidBottomInset: false,
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
                  "Betting",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                37.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      NbField.buttonArrowDown(
                        fieldHeight: 78.h,
                        text: betProvider?.name ?? "Choose Provider",
                        onTap: _chooseProvider,
                        forcedErrorString: providerValidator,
                      ),
                      ChooseContactButton(
                        getContact: _getContact,
                      ),
                      NbField.text(
                          controller: idCntr,
                          fieldHeight: 78.h,
                          hint: "Customer Id",
                          onChanged: buttonValidate,
                          validator: () {
                            if (!NbValidators.isUsername(idCntr.text)) {
                              return "Enter a valid customer id";
                            }
                            return null;
                          }),
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
                              return "Enter a valid amount";
                            } else if (betProvider == null) {
                              return null;
                            } else if (amount <= betProvider!.minAmount) {
                              return betProvider!.betMinError;
                            } else if (amount >= betProvider!.maxAmount) {
                              return betProvider!.betMaxError;
                            } else {
                              return null;
                            }
                          }),
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
                      50.verticalSpace,
                    ]),
                  ),
                ),
                BigPrimaryButton(
                  status: btnStatus,
                  text: "Continue",
                  onTap: _continue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseProvider() async {
    betProvider = await Get.bottomSheet<BetServiceProvider>(
          const GbBetServiceProviderModal(),
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        betProvider;
    setState(() {});
    buttonValidate("val");
  }

  bool get isValid {
    bool validForm = true;
    validForm = formKey.currentState?.validate() ?? false;
    if (betProvider == null) {
      providerValidator = "Select an Betting Service Provider";
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
    } else if (!NbValidators.isUsername(idCntr.text)) {
      isValid = false;
    } else if (betProvider == null) {
      isValid = false;
    } else if (amount == null) {
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
      // int? id;
      // if (addToBeneficiary) {
      //   id = await Get.find<BeneficiariesController>().create(
      //     name: nameCntr.text,
      //     number: idCntr.text,
      //     serviceType: ServiceTypesEnum.betting,
      //     provider: betProvider!,
      //   );
      // }
      BetBill bill = BetBill(
        amount: double.parse(amountCntr.text),
        name: nameCntr.text,
        codeNumber: idCntr.text,
        provider: betProvider!,
        saveBeneficiary: addToBeneficiary,
      );
      setState(() {
        btnStatus = ButtonEnum.active;
      });
      Get.to(() => ConfirmTransactionScreen(bill: bill));
    }
  }

  void _getContact(String contact) {
    idCntr.text = contact;
    setState(() {});
  }
}

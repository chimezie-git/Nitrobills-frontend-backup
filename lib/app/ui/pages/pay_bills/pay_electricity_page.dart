import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/balance_hint_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/choose_contact_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_electricity_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PayElectricityPage extends StatefulWidget {
  const PayElectricityPage({super.key});

  @override
  State<PayElectricityPage> createState() => _PayElectricityPageState();
}

class _PayElectricityPageState extends State<PayElectricityPage> {
  bool addToBeneficiary = false;

  late final TextEditingController nameCntr;
  late final TextEditingController idCntr;
  late final TextEditingController amountCntr;
  ElectricityServiceProvider? electricityProvider;

  String? providerValidator;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameCntr = TextEditingController();
    idCntr = TextEditingController();
    amountCntr = TextEditingController();
  }

  @override
  void dispose() {
    nameCntr.dispose();
    amountCntr.dispose();
    idCntr.dispose();
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
                  "Electricity",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                37.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: electricityProvider?.name ?? "Choose Provider",
                  onTap: _chooseProvider,
                  forcedErrorString: providerValidator,
                ),
                ChooseContactButton(getContact: _chooseContact),
                NbField.text(
                    controller: idCntr,
                    fieldHeight: 78.h,
                    hint: "Customer Id",
                    validator: () {
                      if (idCntr.text.length < 5) {
                        return "Enter a valid customer id";
                      }
                      return null;
                    }),
                const BalanceHintWidget(),
                NbField.text(
                  controller: amountCntr,
                  fieldHeight: 78.h,
                  hint: "Amount",
                  validator: () {
                    double? amount = double.tryParse(amountCntr.text);
                    if (amount == null) {
                      return "Enter a valid amount";
                    } else if (electricityProvider == null) {
                      return null;
                    } else if (amount <= electricityProvider!.minAmount) {
                      return electricityProvider!.electMinError;
                    } else {
                      return null;
                    }
                  },
                ),
                if (addToBeneficiary) ...[
                  32.verticalSpace,
                  NbField.text(
                      controller: nameCntr,
                      hint: "Name",
                      fieldHeight: 78.h,
                      validator: () {
                        if (nameCntr.text.length < 2) {
                          return "Enter a valid name";
                        }
                        return null;
                      })
                ],
                21.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: NbText.sp16("Add this account to beneficiary")
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
                const Spacer(),
                NbButton.primaryBoolLoader(
                  text: "Continue",
                  onTap: _continue,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _chooseProvider() async {
    electricityProvider = await Get.bottomSheet<ElectricityServiceProvider>(
          const GbElectricityServiceProviderModal(),
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        electricityProvider;
    setState(() {});
  }

  bool get isValid {
    bool validForm = true;
    validForm = formKey.currentState?.validate() ?? false;
    if (electricityProvider == null) {
      providerValidator = "Select an Electricity Povider";
      validForm = false;
    }
    setState(() {});
    return validForm;
  }

  void _continue() async {
    if (isValid) {
      setState(() {
        isLoading = false;
      });
      int? id;
      if (addToBeneficiary) {
        id = await Get.find<BeneficiariesController>().create(
          name: nameCntr.text,
          number: idCntr.text,
          serviceType: ServiceTypesEnum.electricity,
          provider: electricityProvider!,
        );
      }
      ElectricityBill bill = ElectricityBill(
        amount: double.parse(amountCntr.text),
        name: nameCntr.text,
        codeNumber: idCntr.text,
        provider: electricityProvider!,
        beneficiaryId: id,
      );
      setState(() {
        isLoading = false;
      });
      Get.to(() => ConfirmTransactionScreen(bill: bill));
    }
  }

  void _chooseContact(String contact) {
    idCntr.text = contact;
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/choose_contact_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_data_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_data_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BuyDataInformation extends StatefulWidget {
  final String? phoneNumber;
  final MobileServiceProvider mobileProvider;
  const BuyDataInformation({
    super.key,
    this.phoneNumber,
    required this.mobileProvider,
  });

  @override
  State<BuyDataInformation> createState() => _BuyDataInformationState();
}

class _BuyDataInformationState extends State<BuyDataInformation> {
  bool addBeneficiary = false;
  late MobileServiceProvider mobileProvider;
  GbDataPlans? dataPlan;
  late final TextEditingController numberCntr;
  late final TextEditingController nameCntr;

  String? planValidator;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    mobileProvider = widget.mobileProvider;
    numberCntr = TextEditingController(text: widget.phoneNumber);
    nameCntr = TextEditingController();
    mobileProvider = widget.mobileProvider;
    super.initState();
  }

  @override
  void dispose() {
    numberCntr.dispose();
    nameCntr.dispose();
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  36.verticalSpace,
                  NbHeader.backAndTitle(
                    "Buy Data",
                    () {
                      Get.back();
                    },
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                    color: NbColors.black,
                  ),
                  21.verticalSpace,
                  NbField.buttonArrowDown(
                    text: mobileProvider.name,
                    onTap: _serviceProvider,
                    fieldHeight: 78.h,
                  ),
                  30.verticalSpace,
                  NbField.buttonArrowDown(
                      text: dataPlan?.name ?? "Data Plan",
                      onTap: _dataProvider,
                      fieldHeight: 78.h,
                      forcedErrorString: planValidator),
                  ChooseContactButton(getContact: _getContact),
                  NbField.text(
                      controller: numberCntr,
                      hint: "Phone Number",
                      fieldHeight: 78.h,
                      keyboardType: TextInputType.number,
                      validator: () {
                        if (!NbValidators.isPhone(numberCntr.text)) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      }),
                  if (addBeneficiary) ...[
                    34.verticalSpace,
                    NbField.text(
                      controller: nameCntr,
                      hint: "Name",
                      fieldHeight: 78.h,
                      validator: () {
                        if (nameCntr.text.length < 2) {
                          return "Enter a valid name";
                        }
                        return null;
                      },
                    )
                  ],
                  29.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: NbText.sp16("Add this number to beneficiary")
                            .w500
                            .black,
                      ),
                      NbField.check(
                        value: addBeneficiary,
                        onChanged: (v) {
                          setState(() {
                            addBeneficiary = v;
                          });
                        },
                      ),
                    ],
                  ),
                  22.verticalSpace,
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
      ),
    );
  }

  Future _serviceProvider() async {
    mobileProvider = await Get.bottomSheet<MobileServiceProvider>(
          const GbDataServiceProviderModal(),
          barrierColor: Colors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        mobileProvider;
    setState(() {});
  }

  Future<void> _dataProvider() async {
    dataPlan = await Get.bottomSheet<GbDataPlans>(
          GbDataPlansModal(provider: mobileProvider),
          barrierColor: Colors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        dataPlan;
    setState(() {});
  }

  bool get isValid {
    bool validForm = true;
    validForm = formKey.currentState?.validate() ?? false;
    if (dataPlan == null) {
      planValidator = "Select a valid data plan";
    }
    setState(() {});
    return validForm;
  }

  void _continue() async {
    if (isValid) {
      // setState(() {
      //   isLoading = false;
      // });
      DataBill bill = DataBill(
        amount: dataPlan!.amount,
        name: nameCntr.text,
        codeNumber: numberCntr.text,
        provider: mobileProvider,
        plan: dataPlan!,
        saveBeneficiary: addBeneficiary,
      );
      // setState(() {
      //   isLoading = false;
      // });
      Get.to(() => ConfirmTransactionScreen(bill: bill));
    }
  }

  void _getContact(String value) {
    numberCntr.text = value;
    setState(() {});
  }
}

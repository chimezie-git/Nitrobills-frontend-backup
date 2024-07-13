import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_cable_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_cable_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_cable_plans.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class PayCableTvPage extends StatefulWidget {
  const PayCableTvPage({super.key});

  @override
  State<PayCableTvPage> createState() => _PayCableTvPageState();
}

class _PayCableTvPageState extends State<PayCableTvPage> {
  bool addToBeneficiary = false;
  TvServiceProvider? cableProvider;
  GbCablePlans? plan;
  late final TextEditingController codeCntr;
  late final TextEditingController nameCntr;

  GlobalKey<FormState> formKey = GlobalKey();
  String? providerValidator;
  String? planValidator;
  final String _providerValidatorTxt = "Select an Cable Service Provider";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameCntr = TextEditingController();
    codeCntr = TextEditingController();
  }

  @override
  void dispose() {
    codeCntr.dispose();
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
                  "Cable TV",
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
                  text: cableProvider?.name ?? "Choose Provider",
                  onTap: _chooseProvider,
                  forcedErrorString: providerValidator,
                ),
                32.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: plan?.name ?? "Subscription",
                  onTap: _chooseSubscription,
                  forcedErrorString: planValidator,
                ),
                32.verticalSpace,
                NbField.text(
                  controller: codeCntr,
                  hint: "Cable Number",
                  fieldHeight: 78.h,
                  validator: () {
                    if (codeCntr.text.length < 5) {
                      return "Enter a valid cable number";
                    }
                    return null;
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
                      child: NbText.sp16("Add this cable to beneficiary")
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
    cableProvider = await Get.bottomSheet<TvServiceProvider>(
          const GbCableServiceProviderModal(),
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        cableProvider;
    setState(() {});
  }

  void _chooseSubscription() async {
    if (cableProvider == null) {
      providerValidator = _providerValidatorTxt;
      setState(() {});
    } else {
      plan = await Get.bottomSheet<GbCablePlans>(
            GbCablePlansModal(provider: cableProvider!),
            barrierColor: NbColors.black.withOpacity(0.2),
            isScrollControlled: true,
          ) ??
          plan;
      setState(() {});
    }
  }

  bool get isValid {
    bool validForm = true;
    validForm = formKey.currentState?.validate() ?? false;
    if (cableProvider == null) {
      providerValidator = _providerValidatorTxt;
      validForm = false;
    }
    if (plan == null) {
      planValidator = "Select a valid ${cableProvider?.name ?? ""} plan";
    }
    setState(() {});
    return validForm;
  }

  void _continue() async {
    if (isValid) {
      setState(() {
        isLoading = false;
      });
      // int? id;
      // if (addToBeneficiary) {
      //   id = await Get.find<BeneficiariesController>().create(
      //     name: nameCntr.text,
      //     number: codeCntr.text,
      //     serviceType: ServiceTypesEnum.cable,
      //     provider: cableProvider!,
      //   );
      // }
      CableBill bill = CableBill(
        amount: plan!.amount,
        name: nameCntr.text,
        codeNumber: codeCntr.text,
        provider: cableProvider!,
        plan: plan!,
        saveBeneficiary: addToBeneficiary,
      );
      setState(() {
        isLoading = false;
      });
      Get.to(() => ConfirmTransactionScreen(bill: bill));
    }
  }
}

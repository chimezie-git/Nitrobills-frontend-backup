import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/data_plan.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/ui/global_widgets/choose_contact_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/data_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/mobile_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BuyDataInformation extends StatefulWidget {
  final String? phoneNumber;
  final MobileServiceProvider? mobileProvider;
  const BuyDataInformation({
    super.key,
    this.phoneNumber,
    this.mobileProvider,
  });

  @override
  State<BuyDataInformation> createState() => _BuyDataInformationState();
}

class _BuyDataInformationState extends State<BuyDataInformation> {
  bool addBeneficiary = false;
  MobileServiceProvider? mobileProvider;
  DataPlan? dataPlan;
  late final TextEditingController numberCntr;
  late final TextEditingController nameCntr;

  @override
  void initState() {
    mobileProvider = widget.mobileProvider;
    numberCntr = TextEditingController(text: widget.phoneNumber);
    nameCntr = TextEditingController(text: widget.mobileProvider?.name);
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
                  text: mobileProvider?.name ?? "Service Provider",
                  onTap: _serviceProvider,
                  fieldHeight: 78.h,
                ),
                30.verticalSpace,
                NbField.buttonArrowDown(
                  text: dataPlan?.name ?? "Data Plan",
                  onTap: _dataProvider,
                  fieldHeight: 78.h,
                ),
                ChooseContactButton(getContact: _getContact),
                NbField.text(
                  controller: numberCntr,
                  hint: "Phone Number",
                  fieldHeight: 78.h,
                ),
                if (addBeneficiary) ...[
                  34.verticalSpace,
                  NbField.text(
                    controller: nameCntr,
                    hint: "Name",
                    fieldHeight: 78.h,
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
                NbButton.primary(text: "Continue", onTap: _continue)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _serviceProvider() async {
    mobileProvider = await Get.bottomSheet<MobileServiceProvider>(
          const MobileServiceProviderModal(),
          barrierColor: Colors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        mobileProvider;
    setState(() {});
  }

  Future<void> _dataProvider() async {
    if (mobileProvider != null) {
      dataPlan = await Get.bottomSheet<DataPlan>(
            DataPlansModal(dataPlans: DataPlan.sample(mobileProvider!)),
            barrierColor: Colors.black.withOpacity(0.2),
            isScrollControlled: true,
          ) ??
          dataPlan;
    }
    setState(() {});
  }

  void _continue() {
    Get.to(() => ConfirmTransactionScreen(
          transaction: Transaction.sampleData,
        ));
  }

  void _getContact(String value) {
    numberCntr.text = value;
    setState(() {});
  }
}

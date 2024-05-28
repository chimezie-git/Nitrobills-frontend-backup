import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/cable_plan.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/widgets/cable_plans_modal.dart';
import 'package:nitrobills/app/ui/global_widgets/cable_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
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
  CablePlan? plan;
  late final TextEditingController nameCntr;

  @override
  void initState() {
    super.initState();
    nameCntr = TextEditingController();
  }

  @override
  void dispose() {
    nameCntr.dispose();
    super.dispose();
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
              ),
              32.verticalSpace,
              NbField.buttonArrowDown(
                fieldHeight: 78.h,
                text: plan?.name ?? "Subscription",
                onTap: _chooseSubscription,
              ),
              if (addToBeneficiary) ...[
                32.verticalSpace,
                NbField.text(
                  controller: nameCntr,
                  hint: "Name",
                  fieldHeight: 78.h,
                )
              ],
              21.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child:
                        NbText.sp16("Add this cable to beneficiary").w500.black,
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
              NbButton.primary(
                text: "Continue",
                onTap: _continue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _chooseProvider() async {
    cableProvider = await Get.bottomSheet<TvServiceProvider>(
          const CableServiceProviderModal(),
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        cableProvider;
    setState(() {});
  }

  void _chooseSubscription() async {
    if (cableProvider != null) {
      plan = await Get.bottomSheet<CablePlan>(
            CablePlansModal(
              cablePlans: CablePlan.sample(cableProvider!),
            ),
            barrierColor: NbColors.black.withOpacity(0.2),
            isScrollControlled: true,
          ) ??
          plan;
      setState(() {});
    }
  }

  void _continue() async {
    Get.to(
      () => ConfirmTransactionScreen(
        transaction: Transaction.sampleCable,
      ),
    );
  }
}

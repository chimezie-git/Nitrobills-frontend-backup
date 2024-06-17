import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/ui/global_widgets/balance_hint_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/choose_contact_button.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/global_widgets/betting_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
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
  late final TextEditingController nameCntr;
  BetServiceProvider? betProvider;

  @override
  void initState() {
    super.initState();
    idCntr = TextEditingController();
    nameCntr = TextEditingController();
  }

  @override
  void dispose() {
    idCntr.dispose();
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
                "Betting",
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
                text: betProvider?.name ?? "Choose Provider",
                onTap: _chooseProvider,
              ),
              ChooseContactButton(
                getContact: _getContact,
              ),
              NbField.text(
                controller: idCntr,
                fieldHeight: 78.h,
                hint: "Customer Id",
              ),
              const BalanceHintWidget(),
              NbField.text(
                fieldHeight: 78.h,
                hint: "Amount",
              ),
              if (addToBeneficiary) ...[
                34.verticalSpace,
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
    betProvider = await Get.bottomSheet<BetServiceProvider>(
          const BettingServiceProviderModal(),
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        betProvider;
    setState(() {});
  }

  void _continue() {
    Get.to(
      () => ConfirmTransactionScreen(
        transaction: Transaction.sampleBetting,
      ),
    );
  }

  void _getContact(String contact) {
    idCntr.text = contact;
    setState(() {});
  }
}

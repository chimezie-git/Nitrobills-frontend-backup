import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/beneficiary.dart';
import 'package:nitrobills/app/data/models/cable_plan.dart';
import 'package:nitrobills/app/data/models/data_plan.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_plan.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/betting_service_provider_modal.dart';
import 'package:nitrobills/app/ui/global_widgets/cable_service_provider_modal.dart';
import 'package:nitrobills/app/ui/global_widgets/electricity_service_provider_modal.dart';
import 'package:nitrobills/app/ui/global_widgets/mobile_service_modal.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/global_widgets/recent_purchase_grid_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/servicetype_modal.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/beneficiary_list_page.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/data_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/widgets/cable_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class SendToBeneficiaryPage extends StatefulWidget {
  final Beneficiary beneficiary;

  const SendToBeneficiaryPage({
    super.key,
    required this.beneficiary,
  });

  @override
  State<SendToBeneficiaryPage> createState() => _SendToBeneficiaryPageState();
}

class _SendToBeneficiaryPageState extends State<SendToBeneficiaryPage> {
  late final TextEditingController amountCntr;
  late ServiceTypesEnum serviceType;
  late AbstractServiceProvider serviceProvider;
  AbstractServicePlan? servicePlan;
  List<Beneficiary> allBeneficiaries = [];

  @override
  void initState() {
    super.initState();
    serviceType = widget.beneficiary.serviceType;
    serviceProvider = widget.beneficiary.serviceProvider;
    if (!serviceType.hasPlan) {
      amountCntr =
          TextEditingController(text: widget.beneficiary.lastPrice?.toString());
    } else {
      amountCntr = TextEditingController();
    }
    allBeneficiaries.add(widget.beneficiary);
  }

  @override
  void dispose() {
    amountCntr.dispose();
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
                  "Send Cheap ${serviceType.shortName.capitalize ?? ""} on Nitro",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                36.verticalSpace,
                NbText.sp16("You are buying data for:").w500.black,
                21.verticalSpace,
                RecentPurchaseGridWidget(
                  beneficiaries: allBeneficiaries,
                  onAdd: _addData,
                  onDelete: (index) {
                    allBeneficiaries.removeAt(index);
                    setState(() {});
                  },
                ),
                20.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: serviceType.name,
                  onTap: _chooseServiceType,
                ),
                32.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: serviceProvider.name,
                  onTap: _chooseServiceProvider,
                ),
                if (serviceType.hasPlan) ...[
                  32.verticalSpace,
                  NbField.buttonArrowDown(
                    fieldHeight: 78.h,
                    text: servicePlan?.name ?? "Choose Plan",
                    onTap: _choosePlan,
                  )
                ],
                32.verticalSpace,
                NbField.text(
                  controller: amountCntr,
                  fieldHeight: 78.h,
                  hint: "Amount",
                ),
                32.verticalSpace,
                32.verticalSpace,
                NbButton.primary(
                  text: "Continue",
                  onTap: _continue,
                ),
                100.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addData() async {
    Beneficiary? beneficiary =
        await Get.to<Beneficiary>(() => BeneficiaryListPage(
              serviceType: serviceType,
              serviceProvider: serviceProvider,
            ));
    if (beneficiary != null) {
      allBeneficiaries.add(beneficiary);
      setState(() {});
    }
  }

  void _choosePlan() async {
    if (serviceType == ServiceTypesEnum.data) {
      servicePlan = await Get.bottomSheet<DataPlan>(
            DataPlansModal(
                dataPlans:
                    DataPlan.sample(serviceProvider as MobileServiceProvider)),
            barrierColor: NbColors.black.withOpacity(0.2),
            isScrollControlled: true,
          ) ??
          servicePlan;
      setState(() {});
    } else if (serviceType == ServiceTypesEnum.cable) {
      servicePlan = await Get.bottomSheet<CablePlan>(
            CablePlansModal(
                cablePlans:
                    CablePlan.sample(serviceProvider as TvServiceProvider)),
            barrierColor: NbColors.black.withOpacity(0.2),
            isScrollControlled: true,
          ) ??
          servicePlan;
      setState(() {});
    }
  }

  void _chooseServiceType() async {
    serviceType = await Get.bottomSheet<ServiceTypesEnum>(
          const ServiceTypeModal(),
          barrierColor: NbColors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        serviceType;
    setState(() {});
  }

  void _chooseServiceProvider() async {
    AbstractServiceProvider? service;
    switch (serviceType) {
      case ServiceTypesEnum.airtime:
      case ServiceTypesEnum.data:
        service = await _getService(const MobileServiceModal());
        break;
      case ServiceTypesEnum.betting:
        service = await _getService(const BettingServiceProviderModal());
        break;
      case ServiceTypesEnum.cable:
        service = await _getService(const CableServiceProviderModal());
        break;
      case ServiceTypesEnum.electricity:
        service = await _getService(const ElectricityServiceProviderModal());
        break;
      default:
        throw Exception("Not available");
    }
    if (service != null) {
      serviceProvider = service;
      setState(() {});
    }
  }

  void _continue() {
    Get.to(
      () => ConfirmTransactionScreen(
        transaction: Transaction.sampleElectricity,
      ),
    );
  }

  Future<AbstractServiceProvider?> _getService(Widget child) async {
    return Get.bottomSheet<AbstractServiceProvider>(
      child,
      barrierColor: NbColors.black.withOpacity(0.2),
      isScrollControlled: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/bet_service_provider.dart';
import 'package:nitrobills/app/data/models/electricity_service_provider.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/tv_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_plan.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/global_widgets/recent_purchase_grid_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/servicetype_modal.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/beneficiary_list_page.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_airtime_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_bet_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_cable_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_cable_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_data_plans_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_data_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/gb_electricity_service_provider_modal.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_cable_plans.dart';
import 'package:nitrobills/app/ui/pages/pay_bills/models/gb_data_plans.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
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
  TextEditingController amountCntr = TextEditingController();
  late ServiceTypesEnum serviceType;
  AbstractServiceProvider? serviceProvider;
  AbstractServicePlan? servicePlan;
  List<Beneficiary> allBeneficiaries = [];

  GlobalKey<FormState> formKey = GlobalKey();

  String? planValidator;
  String? providerValidator;
  String _providerValidatorTxt = "Please Select a service provider";

  @override
  void initState() {
    super.initState();
    serviceType = widget.beneficiary.serviceType;
    serviceProvider = widget.beneficiary.serviceProvider;
    if (serviceType.hasPlan) {
      amountCntr = TextEditingController();
    } else {
      amountCntr = TextEditingController(
          text: widget.beneficiary.lastPayment?.amount.toString());
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
            child: Form(
              key: formKey,
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
                    text: serviceProvider?.name ?? "Select A Service Provider",
                    onTap: _chooseServiceProvider,
                    forcedErrorString: providerValidator,
                  ),
                  32.verticalSpace,
                  if (serviceType.hasPlan)
                    NbField.buttonArrowDown(
                      fieldHeight: 78.h,
                      text: servicePlan?.name ?? "Choose Plan",
                      onTap: _choosePlan,
                      forcedErrorString: planValidator,
                    )
                  else
                    NbField.text(
                        controller: amountCntr,
                        fieldHeight: 78.h,
                        hint: "Amount",
                        keyboardType: TextInputType.number,
                        validator: () {
                          double? amount = double.tryParse(amountCntr.text);
                          if (amount == null) {
                            return "Enter a valid Amount";
                          } else if (serviceProvider == null) {
                            return null; // choose service provider
                          } else {
                            switch (serviceType) {
                              case ServiceTypesEnum.airtime:
                                final prov =
                                    serviceProvider as MobileServiceProvider;
                                if (amount <= prov.minAmount) {
                                  return prov.airtimeError;
                                }
                                break;
                              case ServiceTypesEnum.betting:
                                final prov =
                                    serviceProvider as BetServiceProvider;
                                if (amount <= prov.minAmount) {
                                  return prov.betMinError;
                                } else if (amount >= prov.maxAmount) {
                                  return prov.betMaxError;
                                }
                                break;
                              case ServiceTypesEnum.electricity:
                                final prov = serviceProvider
                                    as ElectricityServiceProvider;
                                if (amount <= prov.minAmount) {
                                  return prov.electMinError;
                                }
                                break;
                              default:
                                break;
                            }
                            return null;
                          }
                        }),
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
      ),
    );
  }

  bool get isValid {
    bool validForm = true;
    validForm = formKey.currentState?.validate() ?? false;
    if (serviceProvider == null) {
      providerValidator = _providerValidatorTxt;
      validForm = false;
    }
    if (serviceType.hasPlan) {
      planValidator = "Please Select a ${serviceType.shortName} plan";
      validForm = false;
    }
    setState(() {});
    return validForm;
  }

  void _addData() async {
    if (isValid) {
      Beneficiary? beneficiary =
          await Get.to<Beneficiary>(() => BeneficiaryListPage(
                serviceType: serviceType,
                serviceProvider: serviceProvider!,
              ));
      if (beneficiary != null) {
        allBeneficiaries.add(beneficiary);
        setState(() {});
      }
    }
  }

  void _choosePlan() async {
    if (serviceProvider == null) {
      providerValidator = _providerValidatorTxt;
      setState(() {});
      return;
    } else {
      providerValidator = null;
    }
    if (serviceType == ServiceTypesEnum.data) {
      servicePlan = await Get.bottomSheet<GbDataPlans>(
            GbDataPlansModal(
              provider: serviceProvider as MobileServiceProvider,
            ),
            isScrollControlled: true,
          ) ??
          servicePlan;
      setState(() {});
    } else if (serviceType == ServiceTypesEnum.cable) {
      servicePlan = await Get.bottomSheet<GbCablePlans>(
            GbCablePlansModal(provider: serviceProvider as TvServiceProvider),
            barrierColor: NbColors.black.withOpacity(0.2),
            isScrollControlled: true,
          ) ??
          servicePlan;
      setState(() {});
    }
  }

  void _chooseServiceType() async {
    ServiceTypesEnum? chosenServiceType =
        await Get.bottomSheet<ServiceTypesEnum>(
      const ServiceTypeModal(onlyServiceType: true),
      barrierColor: NbColors.black.withOpacity(0.2),
      isScrollControlled: true,
    );
    if (chosenServiceType != null) {
      if (chosenServiceType != serviceType) {
        allBeneficiaries.clear(); // remove beneficiaries from list
        serviceType = chosenServiceType;
        serviceProvider = null;
        servicePlan = null;
        setState(() {});
      }
    }
  }

  void _chooseServiceProvider() async {
    AbstractServiceProvider? service;
    switch (serviceType) {
      case ServiceTypesEnum.airtime:
        service = await _getService(const GbAirtimeServiceProviderModal());
        break;
      case ServiceTypesEnum.data:
        service = await _getService(const GbDataServiceProviderModal());
        break;
      case ServiceTypesEnum.betting:
        service = await _getService(const GbBetServiceProviderModal());
        break;
      case ServiceTypesEnum.cable:
        service = await _getService(const GbCableServiceProviderModal());
        break;
      case ServiceTypesEnum.electricity:
        service = await _getService(const GbElectricityServiceProviderModal());
        break;
      default:
        throw Exception("Not available");
    }
    if (service != null) {
      if (service.id != serviceProvider!.id) {
        allBeneficiaries.clear();
        serviceProvider = service;
        servicePlan = null;
        setState(() {});
      }
    }
  }

  void _continue() {
    if (isValid) {
      // Get.to(
      //   () => ConfirmTransactionScreen(
      //     bill: getBill(ben),
      //   ),
      // );
    }
  }

  Future<AbstractServiceProvider?> _getService(Widget child) async {
    return Get.bottomSheet<AbstractServiceProvider>(
      child,
      barrierColor: NbColors.black.withOpacity(0.2),
      isScrollControlled: true,
    );
  }

  Bill getBill(Beneficiary ben) {
    switch (serviceType) {
      case ServiceTypesEnum.airtime:
        return AirtimeBill(
          amount: double.parse(amountCntr.text),
          name: ben.name,
          codeNumber: ben.code,
          provider: serviceProvider as MobileServiceProvider,
          beneficiaryId: ben.id,
        );
      case ServiceTypesEnum.data:
        return DataBill(
          amount: servicePlan!.amount,
          name: ben.name,
          codeNumber: ben.code,
          provider: serviceProvider as MobileServiceProvider,
          plan: servicePlan as GbDataPlans,
          beneficiaryId: ben.id,
        );
      case ServiceTypesEnum.electricity:
        return ElectricityBill(
          amount: double.parse(amountCntr.text),
          name: ben.name,
          codeNumber: ben.code,
          provider: serviceProvider as ElectricityServiceProvider,
          beneficiaryId: ben.id,
        );
      case ServiceTypesEnum.cable:
        return CableBill(
          amount: servicePlan!.amount,
          name: ben.code,
          codeNumber: ben.code,
          provider: serviceProvider as TvServiceProvider,
          plan: servicePlan as GbCablePlans,
          beneficiaryId: ben.id,
        );
      case ServiceTypesEnum.betting:
        return BetBill(
          amount: double.parse(amountCntr.text),
          name: ben.name,
          codeNumber: ben.code,
          provider: serviceProvider as BetServiceProvider,
          beneficiaryId: ben.id,
        );
      default:
        throw Exception("Nitrobills error: Bulk sms is not a valid type");
    }
  }
}

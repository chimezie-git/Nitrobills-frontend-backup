import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/pay_frequency.dart';
import 'package:nitrobills/app/ui/pages/autopayments/widgets/selected_autopay_grid.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/custom_date_picker_dialog.dart';
import 'package:nitrobills/app/ui/global_widgets/frequency_selection_modal.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/global_widgets/servicetype_modal.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/beneficiary_list_page.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_toast.dart';

class SetupAutopaymentPage extends StatefulWidget {
  final Beneficiary? beneficiary;
  const SetupAutopaymentPage({super.key, this.beneficiary});

  @override
  State<SetupAutopaymentPage> createState() => _SetupAutopaymentPageState();
}

class _SetupAutopaymentPageState extends State<SetupAutopaymentPage> {
  late final TextEditingController numberCntr;
  late final TextEditingController priceCntr;
  List<Beneficiary> allBeneficiaries = [];
  ServiceTypesEnum? serviceType;
  AbstractServiceProvider? serviceProvider;
  PayFrequency? frequency;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    if (widget.beneficiary != null) {
      allBeneficiaries.add(widget.beneficiary!);
      serviceType = widget.beneficiary?.serviceType;
      serviceProvider = widget.beneficiary?.serviceProvider;
    }
    numberCntr = TextEditingController();
    priceCntr = TextEditingController();
  }

  @override
  void dispose() {
    numberCntr.dispose();
    priceCntr.dispose();
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
                  "Auto pay",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                20.verticalSpace,
                SelectedAutopayGrid(
                  beneficiary: allBeneficiaries,
                  onAdd: _addData,
                  onDelete: (index) {
                    allBeneficiaries.removeAt(index);
                    setState(() {});
                  },
                ),
                5.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: serviceType == null ? "Service" : serviceName,
                  onTap: _chooseProvider,
                ),
                32.verticalSpace,
                NbField.text(
                  controller: numberCntr,
                  fieldHeight: 78.h,
                  hint: "Number",
                ),
                32.verticalSpace,
                NbField.text(
                  controller: priceCntr,
                  fieldHeight: 78.h,
                  hint: "Amount",
                ),
                32.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: frequency?.period.adjective ?? "Frequency",
                  onTap: _chooseFrequency,
                ),
                32.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: endDate == null
                      ? "End date"
                      : DateFormat("dd MMM yyyy").format(endDate!),
                  onTap: _chooseEndDate,
                ),
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
    if (serviceProvider == null || serviceType == null) {
      NbToast.show(context, "You have not selected a service");
      return;
    }
    Beneficiary? beneficiary =
        await Get.to<Beneficiary>(() => BeneficiaryListPage(
              serviceType: serviceType!,
              serviceProvider: serviceProvider!,
            ));
    if (beneficiary != null) {
      allBeneficiaries.add(beneficiary);
      setState(() {});
    }
  }

  String get serviceName {
    return "${serviceType?.name ?? ""}, ${serviceProvider?.name ?? ""}";
  }

  void _chooseProvider() async {
    (ServiceTypesEnum, AbstractServiceProvider)? modalData =
        await Get.bottomSheet<(ServiceTypesEnum, AbstractServiceProvider)>(
      const ServiceTypeModal(),
      barrierColor: NbColors.black.withOpacity(0.2),
      isScrollControlled: true,
    );
    if (modalData != null) {
      serviceType = modalData.$1;
      serviceProvider = modalData.$2;
      setState(() {});
    }
  }

  void _chooseFrequency() async {
    frequency = await Get.bottomSheet<PayFrequency>(
          const FrequencySelectionModal(),
          backgroundColor: Colors.black.withOpacity(0.2),
          isScrollControlled: true,
        ) ??
        frequency;
    setState(() {});
  }

  void _chooseEndDate() async {
    endDate = await Get.dialog<DateTime>(
          CustomDatePickerDialog(
            currentDate: DateTime.now().add(const Duration(days: 1)),
            lastDate: DateTime.now(),
            selectedDay: endDate,
          ),
          barrierColor: Colors.black.withOpacity(0.2),
        ) ??
        endDate;
    setState(() {});
  }

  void _continue() {
    // Get.to(
    //   () => ConfirmTransactionScreen(
    //     transaction: Transaction.sampleElectricity,
    //   ),
    // );
  }
}

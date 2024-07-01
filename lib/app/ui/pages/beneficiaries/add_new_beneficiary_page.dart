import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/global_widgets/servicetype_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class AddNewBeneficiaryPage extends StatefulWidget {
  const AddNewBeneficiaryPage({super.key});

  @override
  State<AddNewBeneficiaryPage> createState() => _AddNewBeneficiaryPageState();
}

class _AddNewBeneficiaryPageState extends State<AddNewBeneficiaryPage> {
  ServiceTypesEnum? serviceType;
  AbstractServiceProvider? serviceProvider;
  GlobalKey<FormState> formKey = GlobalKey();
  String? serviceValidator;

  final TextEditingController nameCntrl = TextEditingController();
  final TextEditingController numberCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                36.verticalSpace,
                NbHeader.backAndTitle(
                  "Add new beneficiary",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                29.verticalSpace,
                NbField.text(
                    hint: "Name",
                    controller: nameCntrl,
                    fieldHeight: 78.h,
                    validator: () {
                      if (nameCntrl.text.length < 2) {
                        return "Enter a valid name";
                      } else {
                        return null;
                      }
                    }),
                29.verticalSpace,
                NbField.buttonArrowDown(
                  fieldHeight: 78.h,
                  text: _serviceName,
                  onTap: _addService,
                  forcedErrorString: serviceValidator,
                ),
                29.verticalSpace,
                NbField.text(
                  hint: "Number",
                  controller: numberCntrl,
                  keyboardType: TextInputType.number,
                  fieldHeight: 78.h,
                  validator: numValidator,
                ),
                const Spacer(),
                NbButton.primary(text: "Continue", onTap: _continue),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addService() async {
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

  String get _serviceName {
    if (serviceProvider != null && serviceType != null) {
      return "${serviceType!.name}, ${serviceProvider!.name}";
    } else {
      return "Service Provider";
    }
  }

  void _continue() async {
    if (isValid()) {
      final result = await Get.find<BeneficiariesController>().create(
        name: nameCntrl.text,
        number: numberCntrl.text,
        serviceType: serviceType!,
        provider: serviceProvider!,
      );
      if (result != null) {
        Get.back();
      }
    }
  }

  bool isValid() {
    bool validForm = formKey.currentState?.validate() ?? false;
    if (serviceType == null) {
      serviceValidator = "Select a service type";
      validForm = false;
    } else {
      serviceValidator = null;
    }
    setState(() {});
    return validForm;
  }

  String? numValidator() {
    String text = numberCntrl.text;
    switch (serviceType) {
      case null:
        return null;
      case ServiceTypesEnum.airtime:
      case ServiceTypesEnum.data:
        return NbValidators.isPhone(text) ? null : "Enter a valid phone number";
      case ServiceTypesEnum.cable:
      case ServiceTypesEnum.betting:
      case ServiceTypesEnum.electricity:
        return text.length > 5
            ? null
            : "Enter a valid ${serviceType!.shortName} number";
      case ServiceTypesEnum.bulkSms:
        throw Exception("nitrobills error: Not a valid type");
    }
  }
}

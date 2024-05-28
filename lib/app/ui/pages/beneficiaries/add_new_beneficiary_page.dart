import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                fieldHeight: 78.h,
              ),
              29.verticalSpace,
              NbField.buttonArrowDown(
                fieldHeight: 78.h,
                text: _serviceName,
                onTap: _addService,
              ),
              29.verticalSpace,
              NbField.text(
                hint: "Number",
                fieldHeight: 78.h,
              ),
              const Spacer(),
              NbButton.primary(text: "Continue", onTap: _continue),
              20.verticalSpace,
            ],
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

  void _continue() {
    Get.back();
  }
}

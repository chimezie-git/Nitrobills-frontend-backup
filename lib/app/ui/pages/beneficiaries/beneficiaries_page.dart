import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/beneficiary.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/global_widgets/empty_fields_widget.dart';
import 'package:nitrobills/app/ui/global_widgets/servicetype_modal.dart';
import 'package:nitrobills/app/ui/pages/autopayments/setup_autopayment_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/add_new_beneficiary_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/beneficiaries_loading_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/send_to_benficiary_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/a_to_z_modal.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/airtime_dropdown.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/beneficiaries_widget.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/beneficiary_actions_modal.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/last_payment_widget.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/order_selecting_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class BeneficiariesPage extends StatefulWidget {
  const BeneficiariesPage({super.key});

  @override
  State<BeneficiariesPage> createState() => _BeneficiariesPageState();
}

class _BeneficiariesPageState extends State<BeneficiariesPage> {
  int tabIndex = 0;
  ServiceTypesEnum serviceType = ServiceTypesEnum.airtime;
  bool aToZ = true;
  bool lastPayment = true;
  AbstractServiceProvider serviceProvider = MobileServiceProvider.mtn;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<BeneficiariesController>().initialize();
    });
    return GetX<BeneficiariesController>(
      init: Get.find<BeneficiariesController>(),
      builder: (cntrl) {
        if (cntrl.status.value.isLoading) {
          return const BeneficiariesLoadingPage();
        } else {
          return Scaffold(
            backgroundColor: const Color(0xFFEBEBEB),
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        18.verticalSpace,
                        NbText.sp18("Beneficiaries").w600.black,
                        if (cntrl.status.value.isFailed)
                          const EmptyFieldsWidget(
                            image: NbImage.noBeneficiary,
                            text: "You don't have any Saved beneficiary. ",
                          )
                        else
                          Expanded(
                            child: Column(
                              children: [
                                10.verticalSpace,
                                Container(
                                  height: 60.h,
                                  width: double.maxFinite,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  padding: EdgeInsets.only(left: 16.w),
                                  decoration: BoxDecoration(
                                    color: NbColors.white,
                                    borderRadius: BorderRadius.circular(40.r),
                                  ),
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: NbColors.black,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Search beneficiaries",
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF8F8F8F),
                                      ),
                                      border: InputBorder.none,
                                      suffixIcon: SizedBox(
                                        height: 60.h,
                                        width: 20.r,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            NbSvg.search,
                                            colorFilter: const ColorFilter.mode(
                                                Color(0xFF8F8F8F),
                                                BlendMode.srcIn),
                                            width: 20.r,
                                            height: 20.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                SizedBox(
                                  height: 44.h,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      16.horizontalSpace,
                                      AirtimeDropdown(
                                        serviceType: serviceType,
                                        active: tabIndex == 0,
                                        onTap: _pickServiceType,
                                      ),
                                      10.horizontalSpace,
                                      OrderSelectingWidget(
                                        aToZ: aToZ,
                                        active: tabIndex == 1,
                                        onTap: _orderSelect,
                                      ),
                                      10.horizontalSpace,
                                      LastPaymentWidget(
                                        active: tabIndex == 2,
                                        onTap: _lastPayment,
                                      ),
                                      16.horizontalSpace,
                                    ],
                                  ),
                                ),
                                16.verticalSpace,
                                Expanded(
                                  child: ListView(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    children: [
                                      ...Beneficiary.all.where((bene) {
                                        bool sType =
                                            (bene.serviceType == serviceType);
                                        if (lastPayment) {
                                          return (bene.lastPayment != null) &&
                                              sType;
                                        }
                                        return sType;
                                      }).mapIndexed(
                                        (idx, ben) => BeneficiariesWidget(
                                          beneficiary: ben,
                                          index: idx,
                                          onTap: () {
                                            _editBeneficiary(ben);
                                          },
                                        ),
                                      ),
                                      100.verticalSpace,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 100.h,
                    right: 16.w,
                    child: InkWell(
                      onTap: _addBeneficiary,
                      child: Container(
                        width: 72.r,
                        height: 72.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: NbColors.black,
                        ),
                        child: Icon(
                          Icons.add,
                          color: NbColors.white,
                          size: 34.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _lastPayment() {
    tabIndex = 2;
    lastPayment = !lastPayment;
    setState(() {});
  }

  void _orderSelect() async {
    tabIndex = 1;
    NbUtils.removeNav;
    aToZ = await Get.bottomSheet<bool>(const AtoZModal(),
            isScrollControlled: true) ??
        aToZ;
    NbUtils.showNav;
    setState(() {});
  }

  void _pickServiceType() async {
    tabIndex = 0;
    NbUtils.removeNav;
    serviceType = await Get.bottomSheet<ServiceTypesEnum>(
          const ServiceTypeModal(
            onlyServiceType: true,
          ),
          isScrollControlled: true,
        ) ??
        serviceType;
    NbUtils.showNav;
    setState(() {});
  }

  void _addBeneficiary() async {
    NbUtils.removeNav;
    await NbUtils.nav.currentState?.push(
      MaterialPageRoute(
        builder: (context) => const AddNewBeneficiaryPage(),
      ),
    );
    NbUtils.showNav;
  }

  void _editBeneficiary(Beneficiary beneficiary) async {
    NbUtils.removeNav;
    int? idx = await showModalBottomSheet<int>(
        context: NbUtils.nav.currentContext!,
        builder: (context) {
          return BeneficiariesActionsModal(
            serviceType: beneficiary.serviceType,
          );
        });
    if (idx == 1) {
      await NbUtils.nav.currentState?.push(
        MaterialPageRoute(
          builder: (context) => SendToBeneficiaryPage(beneficiary: beneficiary),
        ),
      );
    } else if (idx == 2) {
      await NbUtils.nav.currentState?.push(
        MaterialPageRoute(
          builder: (context) => SetupAutopaymentPage(beneficiary: beneficiary),
        ),
      );
    }

    NbUtils.showNav;
  }
}

import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/beneficiaries_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/models/beneficiary.dart';
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
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/beneficiary_tool_tip.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/last_payment_widget.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/order_selecting_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';
import 'package:nitrobills/app/ui/utils/nb_utils.dart';

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    int tabIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<BeneficiariesController>().initialize(context);
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
                    child: RefreshIndicator(
                      color: NbColors.black,
                      backgroundColor: Colors.white,
                      onRefresh: () async {
                        await cntrl.reload(context);
                      },
                      child: Column(
                        children: [
                          18.verticalSpace,
                          NbText.sp18("Beneficiaries").w600.black,
                          if (cntrl.beneficiaries.isEmpty)
                            EmptyFieldsWidget(
                              image: NbImage.noBeneficiary,
                              text: "You don't have any Saved beneficiary. ",
                              onTap: () {},
                              postfix: infoToolTip(),
                              btnText: "Click the plus button to add",
                            )
                          else
                            Expanded(
                              child: Column(
                                children: [
                                  10.verticalSpace,
                                  Container(
                                    // height: 60.h,
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    padding: EdgeInsets.only(left: 16.w),
                                    decoration: BoxDecoration(
                                      color: NbColors.white,
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: TextField(
                                      onChanged: (v) {
                                        Get.find<BeneficiariesController>()
                                            .serch(v);
                                      },
                                      onSubmitted: (v) {
                                        Get.find<BeneficiariesController>()
                                            .serch(v);
                                      },
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
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 15.r, horizontal: 10.r),
                                        border: InputBorder.none,
                                        suffixIcon: SizedBox(
                                          height: 60.h,
                                          width: 20.r,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              NbSvg.search,
                                              colorFilter:
                                                  const ColorFilter.mode(
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
                                          serviceType:
                                              cntrl.serviceTypeSort.value,
                                          active: tabIndex == 0,
                                          onTap: () {
                                            tabIndex = 0;
                                            _pickServiceType();
                                          },
                                        ),
                                        10.horizontalSpace,
                                        OrderSelectingWidget(
                                          aToZ: cntrl.sortAtoZ.value,
                                          active: tabIndex == 1,
                                          onTap: () {
                                            tabIndex = 1;
                                            _orderSelect();
                                          },
                                        ),
                                        10.horizontalSpace,
                                        LastPaymentWidget(
                                          active: tabIndex == 2,
                                          onTap: () {
                                            tabIndex = 2;
                                            _lastPayment();
                                          },
                                        ),
                                        16.horizontalSpace,
                                      ],
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Expanded(
                                    child: cntrl.filtered.isEmpty
                                        ? ListView(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.w),
                                            children: [
                                              200.verticalSpace,
                                              NbText.sp16(
                                                      'No beneficiary saved for \n${cntrl.serviceTypeSort.value.shortName}')
                                                  .centerText,
                                            ],
                                          )
                                        : ListView.builder(
                                            itemCount: cntrl.filtered.length,
                                            padding: EdgeInsets.fromLTRB(
                                                16.w, 0, 16.w, 100.h),
                                            itemBuilder: (context, index) {
                                              final ben = cntrl.filtered[index];
                                              return BeneficiariesWidget(
                                                  onTap: () => _editBeneficiary(
                                                      context, ben),
                                                  beneficiary: ben,
                                                  index: index);
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  // floating Action button
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
    bool lastPay = Get.find<BeneficiariesController>().sortLastPay.value;
    Get.find<BeneficiariesController>().sort(lastPay: lastPay);
  }

  void _orderSelect() async {
    NbUtils.removeNav;
    final aToZ = await Get.bottomSheet<bool>(const AtoZModal(),
        isScrollControlled: true);
    Get.find<BeneficiariesController>().sort(aToZ: aToZ);
    NbUtils.showNav;
  }

  void _pickServiceType() async {
    NbUtils.removeNav;
    final serviceType = await Get.bottomSheet<ServiceTypesEnum>(
      const ServiceTypeModal(
        onlyServiceType: true,
      ),
      isScrollControlled: true,
    );
    Get.find<BeneficiariesController>().sort(serviceType: serviceType);
    NbUtils.showNav;
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

  void _editBeneficiary(BuildContext context, Beneficiary beneficiary) async {
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
          builder: (context) => SetupAutopaymentPage(
            beneficiary: beneficiary,
          ),
        ),
      );
    } else if (idx == 3) {
      Get.find<BeneficiariesController>().delete(context, beneficiary);
    }

    NbUtils.showNav;
  }

  Widget infoToolTip() {
    return ElTooltip(
      content: const BeneficiaryToolTip(),
      radius: Radius.circular(16.r),
      // color: Colors.transparent,
      color: const Color(0xFFE0E0E0),
      position: ElTooltipPosition.topEnd,
      // distance: 0,
      // showArrow: false,
      child: Container(
        width: 22.r,
        padding: EdgeInsets.zero,
        height: 22.r,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: NbColors.lightGrey,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          NbSvg.iSvg,
          width: 11.r,
          height: 11.r,
          colorFilter: const ColorFilter.mode(
            NbColors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

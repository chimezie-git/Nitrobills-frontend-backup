import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/beneficiary.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/provider/abstract_service_provider.dart';
import 'package:nitrobills/app/ui/pages/autopayments/setup_autopayment_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/add_new_beneficiary_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/send_to_benficiary_page.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/airtime_dropdown.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/beneficiaries_widget.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/beneficiary_actions_modal.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/last_payment_widget.dart';
import 'package:nitrobills/app/ui/pages/beneficiaries/widgets/order_selecting_widget.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
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
                  // if (true)
                  //   const EmptyFieldsWidget(
                  //     image: NbImage.noBeneficiary,
                  //     text: "You don’t have any Saved beneficiary. ",
                  //   )
                  // else
                  Expanded(
                    child: Column(children: [
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
                              onChange: _pickServiceType,
                            ),
                            10.horizontalSpace,
                            OrderSelectingWidget(
                              aToZ: true,
                              active: tabIndex == 1,
                              onChange: _orderSelect,
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
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          children: [
                            ...Beneficiary.all.where((bene) {
                              bool sType = (bene.serviceType == serviceType);
                              if (lastPayment) {
                                return (bene.lastPayment != null) && sType;
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
                      )
                    ]),
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

  void _lastPayment() {
    tabIndex = 2;
    lastPayment = !lastPayment;
    setState(() {});
  }

  void _orderSelect(bool order) {
    tabIndex = 1;
    aToZ = order;
    setState(() {});
  }

  void _pickServiceType(ServiceTypesEnum type) {
    tabIndex = 0;
    serviceType = type;
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

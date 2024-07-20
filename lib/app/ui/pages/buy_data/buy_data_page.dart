import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nitrobills/app/controllers/bills/data_controller.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/hive_box/recent_payments/recent_payment.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/buy_data_information.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/delete_account_modal.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/your_accounts_list_tile.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_hive_box.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BuyDataPage extends StatefulWidget {
  const BuyDataPage({super.key});

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  bool addBeneficiary = false;

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
                  "Buy Data",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                30.verticalSpace,
                NbText.sp16("Buy data easily with Nitro bills."
                        " We will notify you when your data runs out"
                        " and help pay it on time.")
                    .w500
                    .black,
                35.verticalSpace,
                GetBuilder<DataController>(
                  init: Get.find<DataController>(),
                  initState: (s) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.find<DataController>().initializeProvider(context);
                    });
                  },
                  builder: (cntrl) {
                    if (cntrl.status.value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: NbColors.black,
                        ),
                      );
                    }
                    return GridView.builder(
                      itemCount: cntrl.providers.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 32.w,
                        mainAxisSpacing: 19.h,
                      ),
                      itemBuilder: (context, index) {
                        MobileServiceProvider prov = cntrl.providers[index];
                        return _providerTile(prov,
                            prov.id == "MTN" ? BoxFit.cover : BoxFit.fitHeight);
                      },
                    );
                  },
                ),
                30.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: NbHiveBox.recentPayBox.listenable(),
                  builder: (context, value, child) {
                    List<RecentPayment> recents = NbHiveBox.recentPayBox.values
                        .where((rPay) =>
                            rPay.serviceTypesEnum == ServiceTypesEnum.data)
                        .toList();
                    if (recents.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      if (recents.length > 5) {
                        recents = recents.sublist(recents.length - 5);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NbText.sp18("Your Accounts").w600.black,
                          10.verticalSpace,
                          ...List.generate(
                            recents.length,
                            (index) {
                              RecentPayment rPay = recents[index];
                              final provider = MobileServiceProvider
                                  .allDataMap[rPay.serviceProvider]!;
                              return YourAccountsListTile(
                                recentPayment: rPay,
                                provider: provider,
                                onTap: () {
                                  _addInfo(
                                      provider: provider, number: rPay.number);
                                },
                                onDelete: () => deleteAccount(rPay),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _providerTile(MobileServiceProvider provider, BoxFit fit) {
    return InkWell(
      onTap: () {
        _addInfo(provider: provider);
      },
      child: Column(
        children: [
          NbText.sp16(provider.name),
          const Spacer(),
          AspectRatio(
            aspectRatio: 1.3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                image: DecorationImage(
                  fit: fit,
                  image: AssetImage(provider.image),
                ),
                color: NbColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _addInfo({String? number, required MobileServiceProvider provider}) {
    Get.to(
      () => BuyDataInformation(
        phoneNumber: number,
        mobileProvider: provider,
      ),
    );
  }

  void deleteAccount(RecentPayment payment) {
    Get.bottomSheet(DeleteAccountModal(payment: payment),
        isScrollControlled: true);
  }
}

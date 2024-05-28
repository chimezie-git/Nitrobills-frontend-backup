import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/mobile_service_provider.dart';
import 'package:nitrobills/app/data/models/phone_number.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/buy_data/buy_data_information.dart';
import 'package:nitrobills/app/ui/pages/buy_data/widgets/your_accounts_list_tile.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BuyDataPage extends StatefulWidget {
  const BuyDataPage({super.key});

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  bool addBeneficiary = false;

  List<PhoneNumber> numbers = [
    PhoneNumber(number: "23243423423", provider: MobileServiceProvider.mtn),
    PhoneNumber(number: "23243423423", provider: MobileServiceProvider.airtel),
  ];

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
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 32.w,
                    mainAxisSpacing: 19.h,
                  ),
                  children: [
                    _providerTile(MobileServiceProvider.mtn, BoxFit.cover),
                    _providerTile(
                        MobileServiceProvider.airtel, BoxFit.fitHeight),
                    _providerTile(
                        MobileServiceProvider.nineMobile, BoxFit.fitHeight),
                    _providerTile(MobileServiceProvider.glo, BoxFit.fitHeight),
                  ],
                ),
                30.verticalSpace,
                NbText.sp18("Your Accounts").w600.black,
                10.verticalSpace,
                ...numbers.map((p) => YourAccountsListTile(
                      phoneNumber: p,
                      onTap: () {
                        _addInfo(provider: p.provider, number: p.number);
                      },
                    )),
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

  void _addInfo({String? number, MobileServiceProvider? provider}) {
    Get.to(
      () => BuyDataInformation(
        phoneNumber: number,
        mobileProvider: provider,
      ),
    );
  }
}

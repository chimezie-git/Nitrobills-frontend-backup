import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/models/transactions.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/bulk_sms/widgets/messages_field.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BulkSMSPage extends StatefulWidget {
  const BulkSMSPage({super.key});

  @override
  State<BulkSMSPage> createState() => _BulkSMSPageState();
}

class _BulkSMSPageState extends State<BulkSMSPage> {
  List<(String, String)> selectedContacts = [];
  late TextEditingController msgCntr;

  @override
  void initState() {
    super.initState();
    msgCntr = TextEditingController();
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
                  "Bulk SMS",
                  () {
                    Get.back();
                  },
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                  color: NbColors.black,
                ),
                31.verticalSpace,
                NbField.text(hint: "Sender Name", fieldHeight: 78.h),
                33.verticalSpace,
                MessagesField(
                  controller: msgCntr,
                  onChanged: (v) {
                    setState(() {});
                  },
                ),
                25.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: NbField.text(
                        hint: "Recepients",
                        fieldHeight: 78.h,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: _pickContact,
                        child: SizedBox(
                          height: 78.h,
                          child: Center(
                            child: SvgPicture.asset(
                              NbSvg.contacts,
                              width: 23.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                NbText.sp16("Enter phone numbers, seperated by commas")
                    .w500
                    .black,
                43.verticalSpace,
                NbButton.primary(text: "Send Messages", onTap: _sendMessage),
                100.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickContact() async {
    try {
      PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact(askForPermission: true);
      String phone = contact.phoneNumber?.number ?? "";
      String name = contact.fullName ?? "";
      String number = phone.replaceAll(" ", "");

      final newContact = (name, number);
      bool hasContact =
          selectedContacts.indexWhere((element) => element.$2 == number) != -1;
      if (!hasContact) {
        selectedContacts.add(newContact);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _sendMessage() async {
    Get.to(
      () => ConfirmTransactionScreen(transaction: Transaction.sampleSMS),
    );
  }
}

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_headers.dart';
import 'package:nitrobills/app/ui/pages/bulk_sms/models/sms_recepient.dart';
import 'package:nitrobills/app/ui/pages/bulk_sms/widgets/messages_field.dart';
import 'package:nitrobills/app/ui/pages/transactions/confirm_transaction_screen.dart';
import 'package:nitrobills/app/ui/pages/transactions/models/bill.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class BulkSMSPage extends StatefulWidget {
  const BulkSMSPage({super.key});

  @override
  State<BulkSMSPage> createState() => _BulkSMSPageState();
}

class _BulkSMSPageState extends State<BulkSMSPage> {
  late TextEditingController msgCntr;
  late TextEditingController senderCntr;
  late TextEditingController recepientsCntr;
  Map<String, SmsRecepient> recepientMap = {};

  String? recepientValidator;
  String? msgValidator;
  GlobalKey<FormState> formKey = GlobalKey();
  // backspace tracker
  int txtLen = 0;

  @override
  void initState() {
    super.initState();
    msgCntr = TextEditingController();
    recepientsCntr = TextEditingController();
    senderCntr = TextEditingController();
  }

  @override
  void dispose() {
    msgCntr.dispose();
    recepientsCntr.dispose();
    senderCntr.dispose();
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
                    "Bulk SMS",
                    () {
                      Get.back();
                    },
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                    color: NbColors.black,
                  ),
                  31.verticalSpace,
                  NbField.text(
                      hint: "Sender Name",
                      fieldHeight: 78.h,
                      controller: senderCntr,
                      validator: () {
                        if (senderCntr.text.isEmpty) {
                          return "Enter a valid sender name";
                        }
                        return null;
                      }),
                  33.verticalSpace,
                  MessagesField(
                    controller: msgCntr,
                    forcedStringValidator: msgValidator,
                    onChanged: (v) {
                      setState(() {});
                    },
                  ),
                  25.verticalSpace,
                  Wrap(
                    spacing: 5.r,
                    runSpacing: 5.r,
                    children: recepientMap.values
                        .map<Widget>((rec) => recepientChip(rec))
                        .toList(),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 78.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10.w),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: recepientValidator == null
                                  ? const Color(0xFFBBB9B9)
                                  : NbColors.red,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: recepientsCntr,
                            onSubmitted: _addNumber,
                            onChanged: _onChanged,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
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
                  if (recepientValidator != null)
                    NbText.sp12(recepientValidator!).setColor(NbColors.red),
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
      ),
    );
  }

  bool isValid() {
    msgValidator = null;
    recepientValidator = null;
    bool formValid = formKey.currentState?.validate() ?? false;
    if (msgCntr.text.isEmpty) {
      msgValidator = "Message should not be empty";
      formValid = false;
    }
    if (recepientMap.isEmpty) {
      recepientValidator = "Enter contacts of recepients";
      formValid = false;
    }
    setState(() {});
    return formValid;
  }

  void _sendMessage() async {
    if (isValid()) {
      List<String> contacts =
          recepientMap.values.map((rec) => rec.number).toList();
      BulkSMSBill bill = BulkSMSBill(
          amount: 0,
          name: senderCntr.text,
          codeNumber: '',
          contacts: contacts,
          message: msgCntr.text);
      Get.to(() => ConfirmTransactionScreen(bill: bill));
    }
  }

  void _onChanged(String number) {
    if (number.contains(',')) {
      _addNumber(number.replaceAll(',', ''));
    }
  }

  void _addNumber(String number) {
    if (NbValidators.isPhone(number)) {
      recepientValidator = null;
      if (!recepientMap.containsKey(number)) {
        recepientMap[number] = SmsRecepient.phone(number);
        recepientsCntr.clear();
      }
    } else {
      recepientValidator = "Enter a valid number";
    }
    setState(() {});
  }

  void _pickContact() async {
    try {
      PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact(askForPermission: true);
      String name = contact.fullName ?? "";

      if (!recepientMap.containsKey(name)) {
        recepientMap[name] = SmsRecepient.contact(contact);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget recepientChip(SmsRecepient rec) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 4.r),
      decoration: BoxDecoration(
        color: NbColors.primary,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NbText.sp14(rec.name).setColor(NbColors.white),
          4.horizontalSpace,
          InkWell(
            onTap: () {
              recepientMap.remove(rec.name);
              setState(() {});
            },
            child: const Icon(
              Icons.close,
              color: NbColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

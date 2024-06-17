// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:nitrobills/app/data/enums/button_enum.dart';
// import 'package:nitrobills/app/data/services/auth/verify_phone.dart';
// import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
// import 'package:nitrobills/app/ui/utils/nb_colors.dart';
// import 'package:nitrobills/app/ui/utils/nb_image.dart';
// import 'package:nitrobills/app/ui/utils/nb_text.dart';
// import 'package:nitrobills/app/ui/utils/nb_toast.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class HomeOtpModal extends StatefulWidget {
//   final String phoneNumber;
//   const HomeOtpModal({
//     super.key,
//     required this.phoneNumber,
//   });

//   @override
//   State<HomeOtpModal> createState() => _HomeOtpModalState();
// }

// class _HomeOtpModalState extends State<HomeOtpModal> {
//   String otpCode = '';
//   bool loading = true;
//   String verifyId = '';
//   final int otpLength = 6;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _requestAgain();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 1.h,
//             left: 5.w,
//             right: 5.w,
//             height: 110.h,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.r),
//                 color: const Color(0xFF434242),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 10.h,
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: NbColors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(16.r),
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 12.h),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: NbButton.backIcon(_back),
//                     ),
//                     30.verticalSpace,
//                     NbText.sp22("Enter Verification Code").w500.darkGrey,
//                     20.verticalSpace,
//                     NbText.sp16(
//                             "An SMS with a verification code has been sent to your phone")
//                         .w500
//                         .setColor(const Color(0xFF2F3336))
//                         .centerText,
//                     20.verticalSpace,
//                     RichText(
//                       text: TextSpan(
//                         text: "${widget.phoneNumber}  ",
//                         style: TextStyle(
//                             color: const Color(0xFF2F3336),
//                             fontFamily: 'Satoshi',
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     20.verticalSpace,
//                     PinCodeTextField(
//                       onChanged: (v) {
//                         otpCode = v;
//                       },
//                       keyboardType: TextInputType.number,
//                       appContext: context,
//                       obscureText: true,
//                       animationDuration: const Duration(milliseconds: 200),
//                       blinkWhenObscuring: true,
//                       animationType: AnimationType.fade,
//                       blinkDuration: const Duration(milliseconds: 1200),
//                       obscuringWidget: SvgPicture.asset(
//                         NbSvg.obscure,
//                         height: 20.r,
//                       ),
//                       length: otpLength,
//                       textStyle: TextStyle(
//                         fontSize: 26.sp,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xFF2F3336),
//                       ),
//                       pinTheme: PinTheme(
//                         selectedColor: Colors.grey,
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(12.r),
//                         fieldHeight: 46.r,
//                         fieldWidth: 46.r,
//                         activeColor: Colors.grey,
//                         inactiveFillColor: Colors.grey,
//                         activeFillColor: Colors.grey,
//                         inactiveColor: Colors.grey,
//                       ),
//                     ),
//                     20.verticalSpace,
//                     RichText(
//                       text: TextSpan(
//                         text: "Didn't recieve a code? ",
//                         style: TextStyle(
//                             color: const Color(0xFF282828),
//                             fontFamily: 'Satoshi',
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500),
//                         children: [
//                           TextSpan(
//                             text: "Request Again",
//                             style: const TextStyle(
//                               color: Color(0xFF595C5E),
//                               fontFamily: 'Satoshi',
//                               decoration: TextDecoration.underline,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = _requestAgain,
//                           )
//                         ],
//                       ),
//                     ),
//                     25.verticalSpace,
//                     NbButton.primary(
//                       text: "VerifyNumber",
//                       onTap: _verifyNumber,
//                       status: loading ? ButtonEnum.loading : ButtonEnum.active,
//                     ),
//                     30.verticalSpace,
//                     InkWell(
//                         onTap: _skipVefication,
//                         child: Container(
//                           padding: EdgeInsets.all(2.r),
//                           decoration: const BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(color: NbColors.primary),
//                             ),
//                           ),
//                           child: Text(
//                             " Skip Verification ",
//                             style: TextStyle(
//                               color: NbColors.primary,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         )
//                         // .w500.underline.setColor(NbColors.primary),
//                         ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _back() {
//     Get.back();
//   }

//   void _skipVefication() {
//     Get.back();
//   }

//   Future _verifyNumber() async {
//     if (otpCode.length < otpLength) {
//       NbToast.error("OTP incomplete");
//       return;
//     }
//     setState(() {
//       loading = true;
//     });
//     final otpVerified =
//         await VerifyPhone.updatePhoneNumber(PhoneAuthProvider.credential(
//       verificationId: verifyId,
//       smsCode: otpCode,
//     ));
//     setState(() {
//       loading = false;
//     });
//     if (otpVerified.isRight) {
//       NbToast.info("Phone Number Verified");
//       Get.back();
//     } else {
//       NbToast.error(otpVerified.left.message);
//     }
//   }

//   Future _requestAgain() async {
//     setState(() {
//       loading = true;
//     });
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: widget.phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         setState(() {
//           loading = false;
//         });
//         NbToast.info("Phone number already verified");
//         Get.back();
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         setState(() {
//           loading = false;
//         });
//         NbToast.error(e.message ?? "");
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         setState(() {
//           loading = false;
//           verifyId = verificationId;
//         });
//         NbToast.info("Verification SMS sent successfully");
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nitrobills/app/data/enums/service_types_enum.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class AirtimeDropdown extends StatelessWidget {
  final ServiceTypesEnum serviceType;
  final bool active;
  final void Function() onTap;

  const AirtimeDropdown({
    super.key,
    required this.serviceType,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? NbColors.white : const Color(0xFFDCDCDC),
          border: active ? Border.all(color: const Color(0xFF0A6E8D)) : null,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            item(serviceType),
            10.horizontalSpace,
            SvgPicture.asset(
              NbSvg.arrowDown,
              width: 14.r,
              colorFilter: ColorFilter.mode(
                  active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
                  BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(ServiceTypesEnum type) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24.r,
          height: 24.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(img(type)),
            ),
          ),
        ),
        8.horizontalSpace,
        NbText.sp16(type.shortName).w500.setColor(
              active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
            ),
        5.horizontalSpace,
      ],
    );
  }

  String img(ServiceTypesEnum serviceType) {
    if (serviceType == ServiceTypesEnum.airtime) {
      return NbImage.mtn;
    } else {
      return serviceType.img;
    }
  }
}

// class AirtimeDropdown extends StatelessWidget {
//   final ServiceTypesEnum serviceType;
//   final bool active;
//   final void Function(ServiceTypesEnum) onChange;

//   const AirtimeDropdown({
//     super.key,
//     required this.serviceType,
//     required this.active,
//     required this.onChange,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: active ? NbColors.white : const Color(0xFFDCDCDC),
//         border: active ? Border.all(color: const Color(0xFF0A6E8D)) : null,
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: DropdownButton<ServiceTypesEnum>(
//         value: serviceType,
//         items: ServiceTypesEnum.all
//             .map(
//               (e) => DropdownMenuItem<ServiceTypesEnum>(
//                 value: e,
//                 child: item(e),
//               ),
//             )
//             .toList(),
//         onChanged: (v) {
//           if (v != null) {
//             onChange(v);
//           }
//         },
//         underline: const SizedBox.shrink(),
//         icon: SvgPicture.asset(
//           NbSvg.arrowDown,
//           width: 14.r,
//           colorFilter: ColorFilter.mode(
//               active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
//               BlendMode.srcIn),
//         ),
//       ),
//     );
//   }

//   Widget item(ServiceTypesEnum type) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 24.r,
//           height: 24.r,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               image: AssetImage(img(type)),
//             ),
//           ),
//         ),
//         8.horizontalSpace,
//         NbText.sp16(type.shortName).w500.setColor(
//               active ? const Color(0xFF0A6E8D) : const Color(0xFF8F8F8F),
//             ),
//         5.horizontalSpace,
//       ],
//     );
//   }

//   String img(ServiceTypesEnum serviceType) {
//     if (serviceType == ServiceTypesEnum.airtime) {
//       return NbImage.mtn;
//     } else {
//       return serviceType.img;
//     }
//   }
// }

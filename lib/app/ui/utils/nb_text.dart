import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

class NbText {
  static Text sp40(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp28(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp26(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp25(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp22(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp20(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp18(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp17(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp16(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp15(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      );
  static Text sp14(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      );
  static Text sp13(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
      );
  static Text sp12(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      );
}

extension HtTextExtensions on Text {
  Text copyWith({
    FontWeight? fontWeight,
    TextDecoration? decoration,
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    double? height,
  }) =>
      Text(
        data ?? "",
        textAlign: textAlign ?? this.textAlign,
        maxLines: maxLines ?? this.maxLines,

        // style: style?.merge(this.style) ?? this.style,
        style: (style ?? const TextStyle()).copyWith(
          fontWeight: fontWeight,
          color: color,
          height: height,
          decoration: decoration,
        ),
      );

  Text get white => copyWith(color: NbColors.white);
  Text get black => copyWith(color: NbColors.black);
  Text get primary => copyWith(color: NbColors.primary);
  Text get darkGrey => copyWith(color: NbColors.black);
  Text setColor(Color color) => copyWith(color: color);
  Text get centerText => copyWith(textAlign: TextAlign.center);

  Text get justify => copyWith(textAlign: TextAlign.justify);
  Text get w200 => copyWith(fontWeight: FontWeight.w200);
  Text get w300 => copyWith(fontWeight: FontWeight.w300);
  Text get w400 => copyWith(fontWeight: FontWeight.w400);
  Text get w500 => copyWith(fontWeight: FontWeight.w500);
  Text get w600 => copyWith(fontWeight: FontWeight.w600);
  Text get w700 => copyWith(fontWeight: FontWeight.w700);
  Text setMaxLines(int lines) => copyWith(maxLines: lines);
  Text setLinesHeight(double height) => copyWith(height: height);
  Text get strikeThrough => copyWith(decoration: TextDecoration.lineThrough);
  Text get underline => copyWith(decoration: TextDecoration.underline);
}

import 'package:flutter/material.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';

enum ToastTypeEnum {
  info,
  copy,
  error;

  String get svg {
    switch (this) {
      case info:
        return NbSvg.info;
      case copy:
        return NbSvg.copy;
      case error:
        return NbSvg.close;
    }
  }

  Color get textColor {
    switch (this) {
      case info:
        return const Color(0xFF000000);
      case copy:
        return const Color(0xFFFFFFFF);
      case error:
        return const Color(0xFFD12E2E);
    }
  }

  Color get bgColor {
    switch (this) {
      case info:
        return const Color(0xFF2BBBAD);
      case copy:
        return const Color(0xFF201A1A);
      case error:
        return const Color(0xFFFAD2D2);
    }
  }
}

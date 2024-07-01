import 'package:flutter/material.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';

enum ButtonEnum {
  active,
  loading,
  disabled;

  Color get bgColor {
    switch (this) {
      case active:
        return NbColors.black;
      case loading:
        return NbColors.black;
      case disabled:
        return NbColors.black;
      // return const Color(0xFF8F8F8F);
    }
  }

  bool get isLoading => this == loading;
  bool get isActive => this == active;
  bool get isDisabled => this == disabled;
}

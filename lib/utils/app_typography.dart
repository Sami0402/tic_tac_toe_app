import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';

class AppTypographyPoppins {
  static const poppins = 'Poppins';

  static TextStyle get h3 =>
      TextStyle(fontSize: 58, fontFamily: poppins, color: AppColor.white);
  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 24, fontFamily: poppins, color: AppColor.white);
  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 20, fontFamily: poppins, color: AppColor.white);
  static TextStyle get bodySmall =>
      TextStyle(fontSize: 18, fontFamily: poppins, color: AppColor.white);
  static TextStyle get title =>
      TextStyle(fontSize: 15, fontFamily: poppins, color: AppColor.white);
  static TextStyle get caption =>
      TextStyle(fontSize: 12, fontFamily: poppins, color: AppColor.white);
}

class AppTypographyEvilEmpire {
  static const evilEmpire = 'Evil Empire';

  static TextStyle get h3 =>
      TextStyle(fontSize: 50, fontFamily: evilEmpire, color: AppColor.white);
  static TextStyle get displayLarge =>
      TextStyle(fontSize: 24, fontFamily: evilEmpire, color: AppColor.white);
  static TextStyle get displayMedium =>
      TextStyle(fontSize: 20, fontFamily: evilEmpire, color: AppColor.white);
  static TextStyle get displaySmall =>
      TextStyle(fontSize: 18, fontFamily: evilEmpire, color: AppColor.white);
  static TextStyle get title =>
      TextStyle(fontSize: 15, fontFamily: evilEmpire, color: AppColor.white);
  static TextStyle get caption =>
      TextStyle(fontSize: 12, fontFamily: evilEmpire, color: AppColor.white);
}

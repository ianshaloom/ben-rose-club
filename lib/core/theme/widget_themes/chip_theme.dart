import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: C3Colors.white,
    selectedColor: C3Colors.primary,
    disabledColor: C3Colors.grey.withAlpha(40),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: C3Colors.black, fontFamily: 'Urbanist'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: C3Colors.white,
    selectedColor: C3Colors.primary,
    disabledColor: C3Colors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: C3Colors.white, fontFamily: 'Urbanist'),
  );
}

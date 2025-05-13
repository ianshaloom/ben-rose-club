import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: C3Colors.dark,
      side: const BorderSide(color: C3Colors.borderPrimary),
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: C3Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Urbanist'),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: C3Colors.light,
      side: const BorderSide(color: C3Colors.borderPrimary),
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: C3Colors.textWhite,
          fontWeight: FontWeight.w600,
          fontFamily: 'Urbanist'),
    ),
  );
}

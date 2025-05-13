import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: C3Colors.light,
      backgroundColor: C3Colors.primary,
      disabledForegroundColor: C3Colors.darkGrey,
      disabledBackgroundColor: C3Colors.buttonDisabled,
      side: const BorderSide(color: C3Colors.primary),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
      textStyle: const TextStyle(
          fontSize: 16,
          color: C3Colors.textWhite,
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist'),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: C3Colors.light,
      backgroundColor: C3Colors.primary,
      disabledForegroundColor: C3Colors.darkGrey,
      disabledBackgroundColor: C3Colors.darkerGrey,
      side: const BorderSide(color: C3Colors.primary),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
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

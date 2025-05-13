import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: C3Colors.darkGrey,
    suffixIconColor: C3Colors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: TSizes.fontSizeMd,
        color: C3Colors.textPrimary,
        fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(
        fontSize: TSizes.fontSizeSm,
        color: C3Colors.textSecondary,
        fontFamily: 'Urbanist'),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: C3Colors.textSecondary, fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.borderPrimary),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: C3Colors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: C3Colors.darkGrey,
    suffixIconColor: C3Colors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: TSizes.fontSizeMd,
        color: C3Colors.white,
        fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(
        fontSize: TSizes.fontSizeSm,
        color: C3Colors.white,
        fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: C3Colors.white.withAlpha(80), fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: C3Colors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: C3Colors.error),
    ),
  );
}

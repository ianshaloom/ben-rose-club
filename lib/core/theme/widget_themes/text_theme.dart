import 'package:flutter/material.dart';

import '../../constants/colors.dart';

/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: C3Colors.textPrimary),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: C3Colors.textPrimary),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: C3Colors.textPrimary),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: C3Colors.textPrimary),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: C3Colors.textSecondary),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: C3Colors.textSecondary),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: C3Colors.textPrimary),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: C3Colors.textPrimary),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: C3Colors.textSecondary),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: C3Colors.textPrimary),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: C3Colors.textSecondary),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: C3Colors.light),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: C3Colors.light),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: C3Colors.light),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: C3Colors.light),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: C3Colors.light),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: C3Colors.light),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: C3Colors.light),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: C3Colors.light),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: C3Colors.light.withAlpha(50)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: C3Colors.light),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: C3Colors.light.withAlpha(50)),
  );
}

import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: C3Colors.iconPrimary, size: TSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: C3Colors.iconPrimary, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: C3Colors.black,
        fontFamily: 'Urbanist'),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: C3Colors.dark,
    surfaceTintColor: C3Colors.dark,
    iconTheme: IconThemeData(color: C3Colors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: C3Colors.white, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: C3Colors.white,
        fontFamily: 'Urbanist'),
  );
}

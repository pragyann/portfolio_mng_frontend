import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_mng_frontend/utils/utilities.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: ColorPalette.primaryColor,
  colorScheme: const ColorScheme.light(
    primary: ColorPalette.primaryColor,
    secondary: Colors.grey,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedIconTheme: IconThemeData(
      color: ColorPalette.primaryColor,
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: Dimensions.fontSizeExtraLarge + 2,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      )),
  scaffoldBackgroundColor: Colors.white,
);

import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color darkPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackgroundColor = Color(0xFFDFECDB);
  static const Color darkScaffoldBackgroundColor = Color(0xFF060E1E);
  static const Color colorGrey = Color(0xFFC8C9CB);
  static final ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    textTheme: const TextTheme(
      headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: lightPrimary,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimary,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        color: lightPrimary,
        size: 36,
      ),
      unselectedIconTheme: IconThemeData(color: colorGrey, size: 36),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: lightPrimary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: lightPrimary,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    textTheme: const TextTheme(
      headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline5: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkPrimary,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimary,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        color: lightPrimary,
        size: 36,
      ),
      unselectedIconTheme: IconThemeData(color: colorGrey, size: 36),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkScaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: darkPrimary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: darkPrimary,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    ),
  );
}

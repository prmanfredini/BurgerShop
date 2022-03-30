import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
      //brightness: Brightness.dark,
      primaryColor: Color(0xff121212),
      secondaryHeaderColor: Color(0xffF58220),
      canvasColor: Color(0xff121212),
      fontFamily: 'Geomanist',
      textTheme: const TextTheme().apply(
        fontFamily: 'Geomanist',
        bodyColor: Color(0xFFFFFFFF),
        decorationColor: Color(0xFFFFFFFF),
        displayColor: Color(0xFFFFFFFF),
        fontSizeDelta: 16,
        fontSizeFactor: 40
      ),
      colorScheme: ColorScheme.light().copyWith(
        primary: Color(0xff121212),
        secondary: Color(0xffF58220),
        error: Color(0xffE25C5A),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states
                  .contains(MaterialState.disabled)) {
                return Colors.white10;
              }
              return Color(0xffF58220); // Use the component's default.
            },
          ),
        ),
      ),
  );
}
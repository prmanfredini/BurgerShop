import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    //brightness: Brightness.dark,
    primaryColor: const Color(0xff121212),
    secondaryHeaderColor: const Color(0xffF58220),
    canvasColor: const Color(0xff121212),
    fontFamily: 'Geomanist',
    textTheme: const TextTheme().apply(
      fontFamily: 'Geomanist',
      bodyColor: const Color(0xFFFFFFFF),
      decorationColor: const Color(0xFFFFFFFF),
      displayColor: const Color(0xFFFFFFFF),
      fontSizeDelta: 16,
      fontSizeFactor: 40,
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xff121212),
      secondary: const Color(0xffF58220),
      error: const Color(0xffE25C5A),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.white10;
            }
            return const Color(0xffF58220); // Use the component's default.
          },
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.grey,
      selectionHandleColor: Colors.white,
    ),
  );
}

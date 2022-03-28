import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
      //brightness: Brightness.dark,
      primaryColor: Color(0xff121212),
      secondaryHeaderColor: Color(0xffF58220),
      canvasColor: Color(0xff121212),
      fontFamily: 'Geomanist',
      textTheme: const TextTheme().apply(
        bodyColor: Colors.white,
        decorationColor: Colors.white,
        displayColor: Colors.white,
      ),
      colorScheme: ColorScheme.light().copyWith(
        primary: Color(0xff121212),
        secondary: Color(0xffF58220),
        error: Color(0xffE25C5A),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xffF58220),
        textTheme: ButtonTextTheme.normal,
      ));
}
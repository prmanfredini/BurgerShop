import '../../data/datasources/estados.dart';
import 'package:flutter/material.dart';

class AppDependecies extends InheritedWidget {
  final WebEstados webEstados;

  AppDependecies(
      {required this.webEstados,
        required Widget child})
      : super(child: child);

  static AppDependecies? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependecies>();

  @override
  bool updateShouldNotify(AppDependecies oldWidget) {
    return webEstados != oldWidget.webEstados;
  }
}
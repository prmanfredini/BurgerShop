import 'package:burger_shop/features/burgershop/data/models/loading_provider.dart';
import 'package:burger_shop/features/burgershop/data/models/login_validacao.dart';
import 'package:burger_shop/features/burgershop/data/models/signup_validacao.dart';
import 'package:burger_shop/features/burgershop/data/models/user_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/loading.dart';
import 'package:provider/provider.dart';

import 'features/burgershop/domain/usecases/app_dependecies.dart';
import 'features/burgershop/presentation/pages/landing_page.dart';
import 'features/burgershop/presentation/widets/theme.dart';
import 'features/burgershop/data/datasources/estados.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginValidation()),
    ChangeNotifierProvider(create: (context) => SignupValidation()),
    ChangeNotifierProvider(create: (context) => UserValidation()),
    ChangeNotifierProvider(create: (context) => LoadingProvider()),
  ], child: BurgerShop(webEstados: WebEstados())));
}

class BurgerShop extends StatelessWidget {
  final WebEstados webEstados;

  const BurgerShop({Key? key, required this.webEstados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependecies(
      webEstados: WebEstados(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        // builder: (context, child) => Overlay(initialEntries: [
        //   OverlayEntry(
        //     builder: (context) => LoadingCustom(child: LoadingPage()),
        //   )
        // ]),
        home: LandingPage(),
      ),
    );
  }
}

import 'package:burger_shop/features/burgershop/presentation/bloc/login_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/signup_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/user_validacao.dart';
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
        home: LandingPage(),
      ),
    );
  }
}

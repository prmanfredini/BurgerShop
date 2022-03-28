import 'dart:async';

import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/home.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/dot_indicator.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomePage())));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.burgerLoading),
            TypingIndicator(),
          ],
        ),
      ),
    );
  }
}

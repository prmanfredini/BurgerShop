import 'dart:async';

import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/home.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/landing_page.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/loading_provider.dart';

//funçao para builder overlay
/// TODO emplementar essa parte

class LoadingScreen {
  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (context, child) {
      return Overlay(initialEntries: [
        OverlayEntry(
          builder: (context) => LoadingCustom(child: LoadingPage()),
        )
      ]);
    };
  }
}
class LoadingCustom extends StatelessWidget {
  final Widget child;
  const LoadingCustom({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<LoadingProvider>(
            create: (context) => LoadingProvider(),
            builder: (context, _) {
              return Stack(
                  children: [
                    child,
                    Consumer<LoadingProvider>(
                        builder: (context, provider, child) {
                          return provider.loading
                              ? LoadingPage()
                              : LandingPage();
                        }
                    )
                  ]
              );
            }
        )
    );
  }
}


//pagina de loading

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
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

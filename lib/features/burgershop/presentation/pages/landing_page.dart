import 'package:burger_shop/features/burgershop/presentation/bloc/loading_provider.dart';
import 'package:provider/provider.dart';

import 'cadastro.dart';
import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(Assets.imagemLogoLettering),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagemBurgerHome), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Strings.landing,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        child: const Text(Strings.cadastreSe,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Cadastro()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        child: const Text(Strings.entrar,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                  width: 2,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

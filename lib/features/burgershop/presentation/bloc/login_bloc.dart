import 'dart:io';

import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/datasources/login.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/loading_provider.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginBloc {
  WebLogin webLogin = WebLogin();

  validate(String user, String senha, context) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        try {
          var login = await webLogin.doLogin(user, senha);

          if (login == 200) {
            Future.delayed(const Duration(seconds: 2)).whenComplete(() {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoadingPage()));
            });

            /// TODO substituir loading page with provider
            //   Provider.of<LoadingProvider>(context).setLoad(true);
            // Future.delayed(const Duration(seconds: 2)).whenComplete(() {
            //   Provider.of<LoadingProvider>(context).setLoad(false);
            //  });
          }
        } catch (e) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(Strings.wrongLogin),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(Strings.ok))
              ],
            ),
          );
        }
      }
    } on SocketException catch (_) {
      //print('not connected');
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    Strings.conectadoCheck,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const Text(
                    Strings.conectadoHelp,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Image.asset(Assets.imagemConnectionFail),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      child: const Text(
                        Strings.novamente,
                        style: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } on Error catch (_) {
      //print('Erro inesperado');
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    Strings.erroInesperado,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const Text(
                    Strings.erroHelp,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Image.asset(Assets.imagemErroInesperado),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      child: const Text(
                        Strings.ok,
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

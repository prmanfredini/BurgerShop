import 'dart:io';

import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/models/login_validacao.dart';
import 'package:burger_shop/features/burgershop/data/models/usuario_request.dart';
import 'package:burger_shop/features/burgershop/data/network/dio.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginBloc {
  late CustomDio dio;

  LoginBloc(BuildContext context){
    dio = Provider.of<CustomDio>(context, listen: false);
  }

  String path = '/auth/login';
  String method = 'POST';

  validate(String user, String senha, context, LoginValidation validation) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        try {
          final data = LoginUsuario(username: user, password: senha).toJson();

          final login = await dio.request(path, data, method);
          //var login = await webLogin.doLogin(user, senha);

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
          validation.wrongPass();
        }
      }
    } on SocketException catch (_) {
      //print('not connected');
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.54,
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
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Image.asset(Assets.imagemConnectionFail),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      child: const Text(
                        Strings.novamente,
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
    } on Error catch (_) {
      //print('Erro inesperado');
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.54,
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

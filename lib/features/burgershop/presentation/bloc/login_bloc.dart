import 'dart:io';

import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/models/usuario_request.dart';
import 'package:burger_shop/features/burgershop/data/models/usuario_response.dart';
import 'package:burger_shop/features/burgershop/data/network/dio.dart';
import 'package:burger_shop/features/burgershop/data/provider/login_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/loading.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginBloc {
  late CustomDio dio;

  LoginBloc(BuildContext context) {
    dio = Provider.of<CustomDio>(context, listen: false);
  }

  String path = '/auth/login';
  String method = 'POST';

  validate(
      String user, String senha, context, LoginValidation validation) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        try {
          final data = LoginUsuario(username: user, password: senha).toJson();

          final login = await dio.request(path, data, method);

          final UsuarioLogin userLogado = UsuarioLogin.fromJson(login);

          //~salvar dados no provider
          print(userLogado.token);
          print(userLogado.user.fullname);
          validation.setToken(userLogado.token);


          Future.delayed(const Duration(seconds: 2)).whenComplete(() {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoadingPage()));
          });

          /// TODO substituir loading page with provider
          //   Provider.of<LoadingProvider>(context).setLoad(true);
          // Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          //   Provider.of<LoadingProvider>(context).setLoad(false);
          //  });

        } catch (e) {
          validation.wrongPass();
        }
      }
    } on SocketException catch (_) {
      //print('not connected');
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return bottomSheet(
              context,
              Strings.conectadoCheck,
              Strings.conectadoHelp,
              Strings.novamente,
              Assets.imagemConnectionFail,
              () => Navigator.pop(context));
        },
      );
    } on Error catch (_) {
      //print('Erro inesperado');
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return bottomSheet(
              context,
              Strings.erroInesperado,
              Strings.erroHelp,
              Strings.ok,
              Assets.imagemErroInesperado,
              () => Navigator.pop(context));
        },
      );
    }
  }
}

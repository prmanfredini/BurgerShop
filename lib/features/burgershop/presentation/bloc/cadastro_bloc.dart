import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/models/usuario_request.dart';
import 'package:burger_shop/features/burgershop/data/models/usuario_response.dart';
import 'package:burger_shop/features/burgershop/data/network/dio.dart';
import 'package:burger_shop/features/burgershop/data/provider/login_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/cadastro.dart';
import '../pages/loading.dart';

class CadastroBloc {
  late CustomDio dio;

  CadastroBloc(BuildContext context) {
    dio = Provider.of<CustomDio>(context, listen: false);
  }

  String path = '/auth/signup';
  String method = 'POST';

  Future<List<String>> buscaCidades(String estado) async {
    List<String> lista = [];
    final List<dynamic> snapshot =
        await dio.request('/cities-list/$estado', null, 'GET');
    lista.addAll(snapshot.map((e) => e));
    return lista;
  }

  Future<List<String>> buscaEstados() async {
    List<String> lista = [];
    final List<dynamic> snapshot =
        await dio.request('/states-list', null, 'GET');
    lista.addAll(snapshot.map((e) => e));
    return lista;
  }

  validate(String fullname, String user, String cpf, DateTime data,
      String state, String city, String senha, context) async {
    final novoUsuario = CadastroUsuario(
            fullname: fullname,
            username: user,
            cpf: cpf,
            date_birth: data,
            state: state,
            city: city,
            password: senha)
        .toJson();

    print(novoUsuario);

    try {
      //validação de cadastro

      final cadastro = await dio.request(path, novoUsuario, method);

      // path = '/auth/login';
      // final data = LoginUsuario(username: user, password: senha).toJson();
      // final login = await dio.request(path, data, method);
      // print(login['token']);

      if (cadastro != null) {
        showModalBottomSheet(
          context: context,
          builder: (builder) {
            return bottomSheet(context, Strings.newUser, Strings.newUserHelp,
                Strings.fazerLogin, Assets.imagemCadastroSucesso, () async {
              final login = await dio.request(
                  '/auth/login',
                  LoginUsuario(username: user, password: senha).toJson(),
                  method);
              if (login != null) {
              final UsuarioLogin userLogado = UsuarioLogin.fromJson(login);
              print(userLogado.token);
              LoginValidation().setToken(userLogado.token);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoadingPage()));
              }
              return Navigator.of(context).pop;
            });
          },
        );
      }

      // Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (context) => LoadingPage()));
      // });

      /// TODO substituir loading page with provider
      //   Provider.of<LoadingProvider>(context).setLoad(true);
      // Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      //   Provider.of<LoadingProvider>(context).setLoad(false);
      //  });

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

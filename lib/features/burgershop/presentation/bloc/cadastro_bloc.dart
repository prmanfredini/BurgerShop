import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/datasources/cidades.dart';
import 'package:burger_shop/features/burgershop/data/datasources/estados.dart';
import 'package:burger_shop/features/burgershop/data/datasources/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/cadastro.dart';
import '../pages/loading.dart';

class CadastroBloc {
  late CustomDio dio;

  CadastroBloc(BuildContext context){
    dio = Provider.of<CustomDio>(context, listen: false);
  }

  WebCidades webCidades = WebCidades();
  WebEstados webEstados = WebEstados();

  String path = '/auth/signup';
  String method = 'POST';

  Future<List<String>> buscaCidades(String estado) async {
    List<String> lista = [];
    var snapshot = await webCidades.buscarCidades(estado);
    lista.addAll(snapshot.map((e) => e));
    return lista;
  }

  Future<List<String>> buscaEstados() async {
    List<String> lista = [];
    var snapshot = await webEstados.buscarEstados();
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
        password: senha).toJson();

    print(novoUsuario);

    try {

      final cadastro = await dio.request(path, novoUsuario, method);

      if (cadastro == 200) {
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
          content: const Text(Strings.erroInesperado),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(Strings.ok))
          ],
        ),
      );
    }
  }
}

import 'package:burger_shop/features/burgershop/data/datasources/cidades.dart';
import 'package:burger_shop/features/burgershop/data/datasources/estados.dart';
import 'package:flutter/material.dart';

import '../../data/datasources/signup.dart';
import '../../domain/entities/cadastro.dart';
import '../pages/loading.dart';

class CadastroBloc {
  WebCidades webCidades = WebCidades();
  WebEstados webEstados = WebEstados();
  WebCadastro webCadastro = WebCadastro();

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

  formCheck(_key) {
    return _key.currentState?.validate() ?? false;
  }

  validate(String fullname, String user, String cpf, DateTime data,
      String state, String city, String senha, context) {
    var novoUsuario = CadastroUsuario(
        fullname: fullname,
        username: user,
        cpf: cpf,
        date_birth: data,
        state: state,
        city: city,
        password: senha);

    print(novoUsuario.toJson());

    webCadastro.doSignUp(novoUsuario).then((value) => print(value.username));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoadingPage()));
  }
}

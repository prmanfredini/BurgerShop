import 'package:burger_shop/features/burgershop/data/datasources/cidades.dart';
import 'package:burger_shop/features/burgershop/data/datasources/estados.dart';
import 'package:burger_shop/features/burgershop/data/models/cidade_models.dart';
import 'package:burger_shop/features/burgershop/data/models/estado_models.dart';
import 'package:flutter/material.dart';

class CadastroBloc {
  Future<List<String>> buscaCidades(String estado) async {
    print(estado);
    List<String> lista = [];
    var snapshot = await WebCidades().buscarCidades(estado);
    print('parse $snapshot');
    lista.addAll(snapshot.map((e) => e));
    return lista;
    //return Cidades.fromJson(snapshot);
  }

  Future<List<String>> buscaEstados() async {
    //List<EstadosList> estados = [];
    List<String> lista = [];
    var snapshot = await WebEstados().buscarEstados();
    print('parse $snapshot');
    //estados.addAll(snapshot.map((e) => EstadosList.fromJson(e)));
    lista.addAll(snapshot.map((e) => e));
    //print('estados ${estados[0].nome}');
    print('lista $lista');
    return lista;
  }
}

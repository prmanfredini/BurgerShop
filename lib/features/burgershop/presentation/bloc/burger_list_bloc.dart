


import 'package:burger_shop/features/burgershop/data/network/dio.dart';
import 'package:burger_shop/features/burgershop/data/provider/login_validacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/burger_response.dart';

class BurgerBloc {
  late CustomDio dio;
  late LoginValidation user;

  BurgerBloc(BuildContext context) {
    dio = Provider.of<CustomDio>(context, listen: false);
    user = Provider.of<LoginValidation>(context,listen: false);
  }

  String method = 'GET';
  String path = '/hamburger';

  Future <List<BurgerResponse>> buscaBurger() async {
    final List<BurgerResponse> lista = [];

    try {
      final busca = await dio.request(path, null, method, header: {"authorization": "Bearer ${user.token}"} );
      for (var e in busca) {
        lista.add(BurgerResponse.fromJson(e));
      }
      print(lista.length);

      return lista;

    } catch (e) {
      throw Exception('BurgerError');
    }
  }

}

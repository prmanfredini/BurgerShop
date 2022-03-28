
import 'dart:convert';

import 'package:dio/dio.dart';

const String mainURL = "https://burguershop.azurewebsites.net/api/cities-list";

class WebCidades {

  Future<List<dynamic>> buscarCidades(String estado) async{
    final response = await Dio().get(mainURL + '/$estado');
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Erro inesperado');
  }

}

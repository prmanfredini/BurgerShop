import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/network/custom_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

var options = BaseOptions(
  baseUrl: Strings.URL,
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

class CustomDio extends ChangeNotifier {
  Dio dio = Dio(options);

  CustomDio() {
    dio.interceptors.add(CustomInterceptors());
  }

  Future<int?> request(String path, dynamic data, String method) async {
    final response =
        await dio.request(path, data: data, options: Options(method: method));
    if (response.statusCode == 200) {
      return response.statusCode;
      //return UsuarioLogin.fromJson(response.data);
    }
    throw Exception('Erro inesperado');
  }
}

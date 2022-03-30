import 'package:burger_shop/core/strings/strings.dart';
import 'package:dio/dio.dart';


class WebLogin {
  Future<int?> doLogin(String user, String password) async {
    final response = await Dio().post(Strings.URL + '/auth/login',
        data: '{ "username" : "$user", "password" : "$password" }');
    if (response.statusCode == 200) {
      return response.statusCode;
      //return UsuarioLogin.fromJson(response.data);
    }
    throw Exception('Erro inesperado');
  }
}

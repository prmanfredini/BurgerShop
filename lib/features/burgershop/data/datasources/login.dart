import 'package:burger_shop/features/burgershop/data/models/usuario_response.dart';
import 'package:dio/dio.dart';

const String mainURL = "https://burguershop.azurewebsites.net/api/auth/login";

class WebLogin {
  Future<UsuarioLogin> doLogin(String user, String password) async {
    final response = await Dio().post(mainURL,
        data: '{ "username" : "$user", "password" : "$password" }');
    if (response.statusCode == 200) {
      //return response.satusCode;
      return UsuarioLogin.fromJson(response.data);
    }
    throw Exception('Erro inesperado');
  }
}

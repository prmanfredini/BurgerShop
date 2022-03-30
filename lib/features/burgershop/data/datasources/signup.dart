import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/domain/entities/cadastro.dart';
import 'package:dio/dio.dart';


class WebCadastro {
  Future<int?> doSignUp(CadastroUsuario novoUsuario) async {
    final response = await Dio().post(Strings.URL + '/auth/signup', data: novoUsuario.toJson());
    if (response.statusCode == 200) {
      return response.statusCode;
      //return CadastroResponse.fromJson(response.data);
    }
    throw Exception('Erro inesperado');
  }
}

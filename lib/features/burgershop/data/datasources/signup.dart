import 'package:burger_shop/features/burgershop/domain/entities/cadastro.dart';
import 'package:dio/dio.dart';

const String mainURL = "https://burguershop.azurewebsites.net/api/auth/signup";

class WebCadastro {

  Future<CadastroResponse> doSignUp(CadastroUsuario novoUsuario) async{
    final response = await Dio().post(mainURL, data: novoUsuario.toJson());
    if (response.statusCode == 200) {
      print(CadastroResponse.fromJson(response.data).username);
      return CadastroResponse.fromJson(response.data);
    }
    throw Exception('Erro inesperado');
  }

}

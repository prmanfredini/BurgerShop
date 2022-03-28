
import 'package:dio/dio.dart';

const String mainURL = "https://burguershop.azurewebsites.net/api/states-list";

class WebEstados {

  Future<List<dynamic>> buscarEstados() async{
    final response = await Dio().get(mainURL);
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Erro inesperado');

  }

}

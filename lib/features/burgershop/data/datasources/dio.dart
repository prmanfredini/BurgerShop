import 'package:burger_shop/core/strings/strings.dart';
import 'package:dio/dio.dart';

  var options = BaseOptions(
    baseUrl: Strings.URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

class CustomDio{

  Dio dio = Dio(options);


// exemplo
//   String path = '/auth/login';
//   String method = 'POST';
//   String data = '{ "username" : "email@email.com", "password" : "123456" }';

  Future<int?> request(String path, dynamic data ,String method) async {
    final response = await dio.request(path, data: data,
        options: Options(method: method));

     // dio.interceptors.add(InterceptorsWrapper(
     //     onRequest:(options, handler){
     //       print('REQUEST[${options.method}] => PATH: ${options.path}');
     //       // nao entendi .next?
     //       return handler.next(options); //continue
     //       // If you want to resolve the request with some custom data，
     //     },
     //     onResponse:(response,handler) {
     //       print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
     //       return handler.next(response.data); // continue
     //       // If you want to reject the request with a error message,
     //     },
     //     onError: (DioError e, handler) {
     //       print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
     //       return  handler.next(e);//continue
     //       // If you want to resolve the request with some custom data，
     //       // you can resolve a `Response` object eg: `handler.resolve(response)`.
     //     }
     // ));

    if (response.statusCode == 200) {
      return response.statusCode;
      //return UsuarioLogin.fromJson(response.data);
    }
    throw Exception('Erro inesperado');

  }
}
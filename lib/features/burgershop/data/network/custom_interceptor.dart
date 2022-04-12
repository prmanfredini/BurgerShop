import 'package:burger_shop/features/burgershop/data/provider/login_validacao.dart';
import 'package:dio/dio.dart';
class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //Headers.acceptHeader;
    print('REQUEST[${options.method}] => PATH: ${options.path}');
//    if (!options.headers.containsKey("token")) {
//      String? token = LoginValidation().token;
//      options.headers["token"] = token;
//    }
    return super.onRequest(options, handler);
  }
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
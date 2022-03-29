import 'package:burger_shop/features/burgershop/domain/entities/usuario.dart';

class UsuarioLogin{
  final Usuario user;
  final String token;

  UsuarioLogin({required this.user, required this.token});

  factory UsuarioLogin.fromJson(dynamic json) {
    return UsuarioLogin(
      user: Usuario.fromJson(json['user']),
      token: json['token'],
    );
  }
}
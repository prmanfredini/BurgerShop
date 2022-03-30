class LoginUsuario {
  final String username;
  final String password;

  LoginUsuario(
      { required this.username,
        required this.password});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password':password,
  };

}

class CadastroUsuario {
  final String fullname;
  final String username;
  final String cpf;
  final DateTime date_birth;
  final String state;
  final String city;
  final String password;

  CadastroUsuario(
      {required this.fullname,
      required this.username,
      required this.cpf,
      required this.date_birth,
      required this.state,
      required this.city,
      required this.password});
}

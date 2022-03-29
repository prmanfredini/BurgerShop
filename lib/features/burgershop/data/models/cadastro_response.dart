class CadastroResponse {
  final String id;
  final String username;
  final String cpf;
  final String date_birth;
  final String state;

  CadastroResponse(
      {required this.id,
      required this.username,
      required this.cpf,
      required this.date_birth,
      required this.state});

  factory CadastroResponse.fromJson(dynamic json) {
    return CadastroResponse(
      id: json['id'],
      username: json['username'],
      cpf: json['cpf'],
      date_birth: json['date_birth'],
      state: json['state'],
    );
  }
}

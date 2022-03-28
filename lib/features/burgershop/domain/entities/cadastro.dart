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

  // factory CadastroUsuario.fromJson(dynamic json) {
  //   return CadastroUsuario(
  //     fullname: json['fullname'],
  //     username: json['username'],
  //     cpf: json['cpf'],
  //     date_birth: json['date_birth'],
  //     state: json['state'],
  //     city: json['city'],
  //     password: json['password'],
  //   );
  // }

  Map<String, dynamic> toJson() => {
    'fullname': fullname,
    'username': username,
    'cpf': cpf,
    'date_birth': date_birth.toIso8601String(),
    'state': state,
    'city':city,
    'password':password,
  };

}

class CadastroResponse {
  final String id;
  final String username;
  final String cpf;
  final DateTime date_birth;
  final String state;

  CadastroResponse({required this.id, required this.username, required this.cpf, required this.date_birth,required this.state});

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

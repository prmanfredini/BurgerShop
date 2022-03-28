class Usuario {
  //final int id;
  final String username;
  final String fullname;

  Usuario({
    //required this.id,
    required this.username, required this.fullname});

  factory Usuario.fromJson(dynamic json) {
    return Usuario(
      //id: json['id'] as int,
      fullname: json['fullname'],
      username: json['username'],);
  }
}
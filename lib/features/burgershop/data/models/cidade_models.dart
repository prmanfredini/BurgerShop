class Cidades {
  final List<String> nome;

  Cidades({required this.nome});

  factory Cidades.fromJson(dynamic json) {
    return Cidades(
        nome: json);
  }


}
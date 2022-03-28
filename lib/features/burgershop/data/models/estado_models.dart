class EstadosList {
  final List<String> nome;

  EstadosList({required this.nome});

  factory EstadosList.fromJson(dynamic json) {
    return EstadosList(
        nome: json);
  }


}
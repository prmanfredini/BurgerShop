

class Ingredientes {
  final String? id;
  final String ingredient_id;
  final int quantity;

  Ingredientes(
      {required this.id,
        required this.ingredient_id,
        required this.quantity,
      });

  factory Ingredientes.fromJson(dynamic json) {
    return Ingredientes(
      id: json['_id'],
      ingredient_id: json['ingredient_id'],
      quantity: json['quantity'],
    );
  }
}





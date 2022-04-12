

import 'package:burger_shop/features/burgershop/data/models/ingredientes.dart';

class BurgerResponse {
  final String id;
  final String name;
  final double price;
  final String cover;
  final List<Ingredientes> ingredients;
  final String id2;

  BurgerResponse(
      {required this.id,
        required this.name,
        required this.price,
        required this.cover,
        required this.ingredients,
        required this.id2,
      });

  factory BurgerResponse.fromJson(dynamic json) {
    final List<dynamic> jsonIng = json['ingredients'];
    return BurgerResponse(
      id: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      cover: json['cover'],
      ingredients: jsonIng.map((e) => Ingredientes.fromJson(e)).toList(),
      id2: json['id'],
    );
  }
}







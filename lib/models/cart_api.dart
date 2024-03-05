// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Cart> welcomeFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Cart>.from(jsonData.map((x) => Cart.fromJson(x)));
}

String welcomeToJson(List<Cart> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Cart {
  int id;
  int userId;
  String date;
  List<Product> products;
  int v;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => new Cart(
        id: json["id"],
        userId: json["userId"],
        date: json["date"],
        products: new List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date,
        "products": new List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };
}

class Product {
  int productId;
  int quantity;

  Product({
    required this.productId,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}

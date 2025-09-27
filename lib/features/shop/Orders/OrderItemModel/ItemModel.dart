import 'package:flutter/foundation.dart';

class ItemModel{

  ItemModel( {
    required this.price,
    required this.quantity,
    required this.productId,
    required this.title,
    required this.image,
});

  final String productId;
  final String title;
  final int price;
  final int quantity;
  final String image;

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      productId: json['ProductId'] ?? "",
      title: json['Title'] ?? "",
      price: json['Price'] ?? "",
        quantity: json['Quantity'] ?? "",
      image: json['Image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "ProductId": productId,
        "Title": title,
        "Price": price,
        "Quantity": quantity,
        "Image": image,
      };

}
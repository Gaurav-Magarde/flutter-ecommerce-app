import 'package:clone_shopping/features/shop/models/product_attribute.dart';
import 'package:clone_shopping/features/shop/models/product_variation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../product_model.dart';

class CartModel {
  CartModel({
    required this.brand,
    required this.quantity,
    required this.price,
    required this.salePrice,
    required this.image,
    required this.title,
    required this.productId,
    this.color,
    this.size,
  });

  final String brand;
  final int quantity;
  final double price;
  final String image;
  final String title;
  final String productId;
  final String? color;
  final String? size;
  final int salePrice;

  Map<String, dynamic> toJson() => {
    "Brand": brand,
    "Quantity": quantity,
    "Price": price,
    "Image": image,
    "Title": title,
    "ProductId": productId,
    "Color": color,
    "Size": size,
    "SalePrice": salePrice,
  };

  factory CartModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return CartModel(
      productId: data["ProductId"],
      brand: data['Brand'],
      quantity: data['Quantity'],
      price: data['Price'],
      image: data['Image'],
      title: data['Title'],
      color: data['Color'],
      size: data['Size'],
      salePrice: data['SalePrice'],
    );
  }

  factory CartModel.fromProduct(ProductModel product, {int qty = 1, required ProductVariationModel variation,List<ProductAttributeModel> attributes = const []}){
    return CartModel(
      productId: product.id,
      brand: product.brand?.name ?? "Not certified",
      quantity: qty,
      price: variation.price,
      image: variation.image,
      title: product.title,
      color: attributes.isNotEmpty ? attributes.firstWhereOrNull((element) => element.name == "Color")?.values![0] : null,
      size: attributes.isNotEmpty ? attributes.firstWhereOrNull((element) => element.name == "Size")?.values![0] : null,
      salePrice: variation.salePrice.toInt(),
    );
  }

  static empty() {
    return CartModel(
      brand: "",
      quantity: 0,
      price: 0,
      image: "",
      title: '',
      productId: '',
      salePrice: 0,
    );
  }
}

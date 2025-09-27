import 'package:cloud_firestore/cloud_firestore.dart';

class WishListModel {
  WishListModel({
    required this.image,
    required this.productId,
    required this.title,
    required this.brand,
    required this.off,
  });

  final String image;
  final String productId;
  final String title;
  final String brand;
  final String off;


  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'ProductId': productId,
      'Title': title,
      'Brand': brand,
      'Off': off,
    };
  }

  factory WishListModel.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return WishListModel(
      image: data['Image'],
      productId: snapshot.id,
      title: data['Title'],
      brand: data['Brand'],
      off: data['Off'],
    );


  }

}

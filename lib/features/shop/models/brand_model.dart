import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount,
  });

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if(kDebugMode) print(data);
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }


  /// Create BrandModel directly from Firebase DocumentSnapshot
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {

    if(kDebugMode) print("empty");

    if (!snapshot.exists || snapshot.data() == null) {
      return BrandModel.empty();
    }

    final data = snapshot.data()!;
    return BrandModel.fromJson(data);
  }

  /// CopyWith (optional, for updating only specific fields)
  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    int? productsCount,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      productsCount: productsCount ?? this.productsCount,
    );
  }
}

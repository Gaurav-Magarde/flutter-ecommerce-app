import 'package:clone_shopping/features/shop/models/product_attribute.dart';
import 'package:clone_shopping/features/shop/models/product_variation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'brand_model.dart';

class ProductModel {

  String id;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductVariationModel> productVariations;
  List<ProductAttributeModel>? productAttributes;
  int reviews = 0;
  double rating = 0.0;
  int noOfProductVariations = 0;
  String thumbnail;

  ProductModel._({
    required this.id,
    required this.title,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.isFeatured,
    this.description,
    this.categoryId,
    this.productAttributes,
    required this.productVariations,
    this.reviews = 0,
    this.rating = 0.0,
  }): noOfProductVariations = productVariations.length,
      price = productVariations.isNotEmpty ? productVariations[0].price : 0,
      salePrice =  productVariations.isNotEmpty ? productVariations[0].salePrice : 0,
      thumbnail = productVariations.isNotEmpty ? productVariations[0].image : "";




  /// Empty func for clean code
  static ProductModel empty() => ProductModel._(
    id: '',
    title: '',
    productType: '',
    productVariations: [],

  );

  Map<String, dynamic> toJson() {
    return {
      'Reviews' : 0,
      'Rating' : 0.0,
      'Title': title,
      'ProductType': productType,
      'SKU': sku,
      'Brand': brand?.toJson(),
      'Date': date?.toIso8601String(),
      'IsFeatured': isFeatured ?? false,
      'Description': description,
      'CategoryId': categoryId,
      'NoOfProductVariations': productVariations.length,
      'Images': images ?? [],
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations.isNotEmpty ? productVariations.map((e) => e.toJson()).toList() : [],
    };
  }

  ///To get and show the lowest price available in the product
  ProductVariationModel? get cheapestVariation {
    if (productVariations.isEmpty) return null;

    // List ko copy karke price ke hisab se sort karo
    final sortedVariations = List<ProductVariationModel>.from(productVariations);
    sortedVariations.sort((a, b) {
      final priceA = a.salePrice > 0 ? a.salePrice : a.price;
      final priceB = b.salePrice > 0 ? b.salePrice : b.price;
      return priceA.compareTo(priceB);
    });

    return sortedVariations.first;
  }

  double get priceThumbnail{
    return cheapestVariation?.price ?? 0.0;
  }

  double get salePriceThumbnail{
    return cheapestVariation?.salePrice ?? 0.0;
  }

  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    if (data.isEmpty) return ProductModel.empty();

    List<ProductVariationModel> sortedVariations = data['ProductVariations'] != null
        ? List<ProductVariationModel>.from(
      data['ProductVariations'].map(
            (e) => ProductVariationModel.fromJson(e),
      ),
    )
        : [];
    sortedVariations.sort((a, b) {
      final priceA = a.salePrice > 0 ? a.salePrice : a.price;
      final priceB = b.salePrice > 0 ? b.salePrice : b.price;
      return priceA.compareTo(priceB);
    });

    return ProductModel._(
      id: document.id,
      title: data['Title'] ?? '',
      productType: data['ProductType'] ?? '',
      sku: data['SKU'],
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      date: data['Date'] != null ? DateTime.tryParse(data['Date']) : null,
      isFeatured: data['IsFeatured'] ?? false,
      description: data['Description'],
      categoryId: data['CategoryId'],
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? List<ProductAttributeModel>.from(
              data['ProductAttributes'].map(
                (e) => ProductAttributeModel.fromJson(e),
              ),
            )
          : [],
      productVariations: sortedVariations,
      reviews : data["Reviews"] ?? 0,
      rating: data["Rating"] ?? 0.0,
    );

  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    List<ProductVariationModel> sortedVariations = data['ProductVariations'] != null
        ? List<ProductVariationModel>.from(
      data['ProductVariations'].map(
            (e) => ProductVariationModel.fromJson(e),
      ),
    )
        : [];
    sortedVariations.sort((a, b) {
      final priceA = a.salePrice > 0 ? a.salePrice : a.price;
      final priceB = b.salePrice > 0 ? b.salePrice : b.price;
      return priceA.compareTo(priceB);
    });
    return ProductModel._(
      id: document.id,
      title: data['Title'] ?? '',
      productType: data['ProductType'] ?? '',
      sku: data['SKU'],
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      date: data['Date'] != null ? DateTime.tryParse(data['Date']) : null,
      isFeatured: data['IsFeatured'] ?? false,
      description: data['Description'],
      categoryId: data['CategoryId'],
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? List<ProductAttributeModel>.from(
        data['ProductAttributes'].map(
              (e) => ProductAttributeModel.fromJson(e),
        ),
      )
          : [],
      productVariations: sortedVariations,
      reviews : data["Reviews"] ?? 0,
      rating: data["Rating"] ?? 0.0,
    );

  }
  // Map Json-oriented document snapshot from Firebase to Model
  // factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
  //   final data = document.data() as Map<String, dynamic>;
  //   return ProductModel.fromJson(data);
  // }
}

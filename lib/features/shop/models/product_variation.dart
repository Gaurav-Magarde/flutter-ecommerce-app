class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String description;
  double price;
  double salePrice;
  int stock;
  String thumbnail;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    required this.thumbnail,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Empty func for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {},thumbnail: "");

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      sku: data['SKU'] ?? '',
      description: data['Description'] ?? '',
      stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      attributeValues:  {},
    );
  }

  Map<String, dynamic> toJson() => {
    "Id" : id,
    "Thumbnail" : thumbnail,
    "SKU" : sku,
    "Image" : image,
    "Description" : description,
    "Price" : price,
    "SalePrice" : salePrice,
    "Stock" : stock,
    "AttributeValues" : attributeValues,

  };

}

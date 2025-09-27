class ProductAttributeModel {
  final String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  /// Convert Model to JSON format
  Map<String, dynamic> toJson(){
    return {
      'Name': name,
      'Values': values,
    };
  }

  /// Create Model from JSON (Firebase document snapshot)
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: document.containsKey('Name') ? document['Name'] as String? : '',
      values: document['Values'] != null
          ? List<String>.from(document['Values'])
          : [],
    );
  }
}

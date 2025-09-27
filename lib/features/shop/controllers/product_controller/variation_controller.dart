import 'package:clone_shopping/features/shop/models/product_variation.dart';
import 'package:get/get.dart';

import '../../models/product_attribute.dart';
import '../../models/product_model.dart';

class VariationController extends GetxController{

  static VariationController get instance => Get.find();

  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;
  RxList<ProductAttributeModel> allAttributes = <ProductAttributeModel>[].obs;
  RxList<Map<String, dynamic>> selectedAttributes = <Map<String, dynamic>>[].obs;

  List<ProductVariationModel> variations = [];

  void selectVariation(ProductVariationModel variation){
    selectedVariation.value = variation;
    // fetchAllAttributes(variation);
  }
  //
  // void fetchAllAttributes(ProductVariationModel variation){
  //   selectedAttributes.clear();
  //   allAttributes.clear();
  //   allAttributes = variation.attributeValues.obs;
  //   allAttributes.map((attribute) => selectedAttributes.add({?attribute.name  : attribute.values?[0]}));
  // }

  void fetchAllVariations(ProductModel product){
    variations = product.productVariations;
    selectedVariation.value = variations[0];
    // fetchAllAttributes(variations[0]);

  }
}
import 'package:clone_shopping/features/shop/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/product_attribute.dart';

class AttributeController extends GetxController{

  AttributeController({required this.product});

  @override
  onInit(){
    attributes = product.productAttributes ?? [];
    super.onInit();
  }



  static AttributeController get instance => Get.find();

  final ProductModel product;

  List<ProductAttributeModel> attributes = <ProductAttributeModel>[];

  RxList<ProductAttributeModel> selectedAttributes = <ProductAttributeModel>[].obs;


}

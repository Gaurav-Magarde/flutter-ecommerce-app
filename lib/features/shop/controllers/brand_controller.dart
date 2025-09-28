import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';
import '../Repositries/brand_repository.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandController extends GetxController{

  static BrandController get instance => Get.find();

  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchAllBrands();

  }

  Future<void> fetchAllBrands() async {
    try {
      isLoading.value = true;
     final controller =  Get.put( BrandRepository());
      final list = await controller.fetchAllBrands();//here error The method 'fetchAllBrands' isn't defined for the type 'Function'. (Documentation)


      allBrands.assignAll(list);

      featuredBrands.assignAll(list.where((element) => element.isFeatured ?? false).toList());

    } catch(e) {
      TLoaders.errorSnackBar(title: "oh snap",message: e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

  Query queryForBrand(String name){
    return  FirebaseFirestore.instance.collection('Products').where("NoOfProductVariations",isGreaterThan: 0).where('Brand.Name', isEqualTo: name).limit(10);
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final controller =  Get.put(BrandRepository());
      final list = await controller.fetchBrandsForCategory(categoryId);//here error The method 'fetchAllBrands' isn't defined for the type 'Function'. (Documentation)();
      return list;
    } catch(e) {
      TLoaders.errorSnackBar(title: "oh snap",message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProductsForBrand({int limit = 2,required String brandId,}) async {
    try {
      isLoading.value = true;
      final controller = Get.put(BrandRepository());
      final list = await controller.fetchProductsForBrand(brandId: brandId,limit:  limit );
      return list;
    }catch(e){
      TLoaders.errorSnackBar(title: "oh snap",message: e.toString());
      return [];
    }
  }
}
import 'package:clone_shopping/data/repositries/ProductRepository/product_repository.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class AllProductsController extends GetxController{

  static AllProductsController get instance => Get.find();

  RxList<ProductModel> sortedProducts = <ProductModel>[].obs;
  RxString selectedSort = "Higher Price".obs;

  Future<List<ProductModel>> getFeaturedProducts(Query? query) async {

    try{
      if(query == null) return [];
      final list = await  ProductRepository.instance.fetchProductsByQuery(query);
      if(kDebugMode) print("here passed $list");
      return list;

    }catch(e){
      TLoaders.errorSnackBar(title: "oh Snap",message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortBy) {
    selectedSort.value = sortBy;
    switch (sortBy){
      case "Name":
        sortedProducts.sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Higher Price":
        sortedProducts.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      case "Lower Price":
        sortedProducts.sort((a, b) => a.salePrice.compareTo(b.salePrice));
        break;
      case "sale":
        sortedProducts.sort((a, b) {
          final bPercent = (b.salePrice / b.price) * 100;
          final aPercent = (a.salePrice / a.price) * 100;
          if (bPercent == aPercent) {
            return b.salePrice.compareTo(a.salePrice);
          }
          return bPercent.compareTo(aPercent);
        });
        break;
      default:
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
    }
  }

  void assignProducts(List<ProductModel> products){
    sortedProducts.value = products;
          selectedSort("Higher Price");
  }
}
import 'package:get/get.dart';

import '../../../../data/repositries/ProductRepository/product_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController{

   static ProductController get instance => Get.find();

   final _productRepository = Get.put(ProductRepository());
   final isLoading = false.obs;
   RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

   @override
  void onInit() {

     fetchFeaturedProducts();
     super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
     try{
       isLoading.value = true;
       final products = await _productRepository.getFeaturedProducts();
       featuredProducts.assignAll(products);


     }catch(e){
       TLoaders.errorSnackBar(title: "ohSnap on fetching products",message: e.toString());
     }
     finally{
       isLoading.value = false;
     }
  }

   // Get the product price or price range for variations
   String getProductPrice(ProductModel product) {
     double smallestPrice = double.infinity;
     double largestPrice = 0.0;

     if (product.productType == "Single") {
       double priceToReturn = product.salePrice > 0 ? product.salePrice : product.price;
       return priceToReturn.toString();
     }

     for (var variation in product.productVariations) {
       // Check if salePrice available else take regular price
       double priceToConsider = variation.salePrice > 0 ? variation.salePrice : variation.price;

       // Update smallest and largest
       if (priceToConsider < smallestPrice) {
         smallestPrice = priceToConsider;
       }
       if (priceToConsider > largestPrice) {
         largestPrice = priceToConsider;
       }
     }

     if (smallestPrice == largestPrice) {
       return largestPrice.toString();
     }

     return '$smallestPrice - $largestPrice';
   }


   String? getProductSalePercentage(double originalPrice, double? salePrice) {
     if(salePrice == null || salePrice <= 0)   return null;
     if(originalPrice == 0) return null;


     double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
     return "${percentage.toStringAsFixed(0)}%";
  }


  String getProductStockStatus(int stock) {
     return stock > 0 ? "In Stock" : "Out of Stock";
  }


  Future<void> uploadProduct() async {
     try {
      // await _productRepository.uploadDummyProducts();
      TLoaders.successSnackBar(title: "Success",message: "Products uploaded successfully");
     }catch(e){
       TLoaders.errorSnackBar(title: "ohSnap",message: e.toString());
     }
  }

  Future<List<ProductModel>> getProductsForCategory(String categoryId,{int limit = 2}) async {
     try{
       // isLoading.value = true;
       final products = await _productRepository.getProductsForCategory(categoryId,limit: limit);
       // isLoading.value = false;
       return products;

     }catch(e){
       TLoaders.errorSnackBar(title: "ohSnap on fetching products",message: e.toString());
       return [];
     }
  }
}
import 'package:clone_shopping/features/shop/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/BrandCard/brands_showCase.dart';
import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';
import '../../models/product_model.dart';

class CategoryBrands extends StatelessWidget {
  const   CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(BrandController());
    return FutureBuilder(future: controller.getBrandsForCategory('1')
        , builder: (context,snapshot){

      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }

      if(snapshot.hasError){
        if(kDebugMode) print("Something went wrong v11111111")     ;

        return Center(child: Text("Something went wrong"));
      }

      if(snapshot.data == null || snapshot.data!.isEmpty ){
        return Center(child: Text("No brands found"));
      }
      List<BrandModel> brands = snapshot.data!;
      if(brands.isEmpty){
        return Center(child: Text("No brands found"));
      }
      return ListView.builder(
        itemCount: brands.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){

        final brand = brands[index];

        return FutureBuilder(future: controller.getProductsForBrand(brandId: brand.id)
            , builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
           if(kDebugMode) print("products length iserrrrrrrrrrre")     ;
            return Center(child: Text("Something went wrong"));
          }

          if(snapshot.data == null){
            return Center(child: Text("No products found"));
          }

          List<ProductModel> products = snapshot.data!;

          if(products.isEmpty){
            return Center(child: Text("No products found"));
          }


          return  Center(child: Text("products found"));


        });
      });
    });
  }
}

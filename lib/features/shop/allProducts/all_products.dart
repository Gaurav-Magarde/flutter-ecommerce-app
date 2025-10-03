import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/features/shop/allProducts/sortable_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/shimmer/product_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/all_product_controller.dart';
import '../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, this.futureMethod, this.query, required this.title});

  final String title;
  final Future<List<ProductModel>>?  futureMethod;
  final Query? query;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.getFeaturedProducts(query),
            builder: (context, asyncSnapshot) {
              if(asyncSnapshot.connectionState == ConnectionState.waiting){

                return ProductShimmer();
              }


              if(asyncSnapshot.hasError){
                return Text(asyncSnapshot.error.toString());
              }

              if(!asyncSnapshot.hasData || asyncSnapshot.data==null || asyncSnapshot.data!.isEmpty ){
                return Text("No Products Found");
              }
                final productList = asyncSnapshot.data!;
              return SortableProduct(productList: productList);
            }
          )
        ),
      ),
    );
  }
}

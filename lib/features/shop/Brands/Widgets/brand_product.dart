import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../allProducts/sortable_product.dart';
import '../../controllers/all_product_controller.dart';
import '../../models/product_model.dart';

class BrandProduct extends StatelessWidget {
  const BrandProduct({super.key, required this.title,required this.querySnapshot});
  final String title;
  final Query querySnapshot;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: controller.getFeaturedProducts(querySnapshot),
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<ProductModel>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  final List<ProductModel>? list = snapshot.data;

                  if (list == null || list.isEmpty) {
                    return Center(child: Text("No Products Found"));
                  }

                  return Column(children: [SortableProduct(productList: list)]);
                },
          ),
        ),
      ),
    );
  }
}

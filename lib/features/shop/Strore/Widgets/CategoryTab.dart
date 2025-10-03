import 'package:clone_shopping/common/widgets/products/product_card/productCardVertical.dart';
import 'package:clone_shopping/features/shop/Strore/Widgets/category_brands.dart';
import 'package:clone_shopping/features/shop/allProducts/sortable_product.dart';
import 'package:clone_shopping/features/shop/controllers/categoryController/category_controller.dart';
import 'package:clone_shopping/features/shop/controllers/product_controller/product_controller.dart';
import 'package:clone_shopping/features/shop/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/texts/SectionHeading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../allProducts/all_products.dart';
import '../../home/widgets/GridView.dart';
import '../../models/product_model.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: category,),
              const SizedBox(height: TSizes.spaceBtwItems),
              SectionHeading(
                title: 'You may like',
                showActionButton: true,
                onPressed: () {
                  Get.to(()=>AllProducts(
                  title: category.name,
                  futureMethod: ProductController.instance.getProductsForCategory(category.id,limit: -1),
                  ));
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder(
                future: ProductController.instance.getProductsForCategory(category.id),
                builder: (context, asyncSnapshot) {

                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (asyncSnapshot.hasError) {
                    return Center(
                      child: Text('Error: ${asyncSnapshot.error}'),
                    );
                  }

                  if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  }

                  List<ProductModel> products = asyncSnapshot.data!;
                  return GridViewLayout(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, index) {
                      return ProductCartVertical(
                        title: products[index].title,
                        image: products[index].thumbnail,
                        price: products[index].price,
                        salePrice: products[index]
                            .salePrice,
                        productId: products[index].id,
                        brandName:
                        products[index].brand?.name ?? " ", onCartTap: () {  },
                      );
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
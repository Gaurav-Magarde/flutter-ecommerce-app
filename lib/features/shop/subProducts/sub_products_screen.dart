import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/features/shop/controllers/categoryController/category_controller.dart';
import 'package:clone_shopping/features/shop/controllers/product_controller/product_controller.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/products/product_card/product_cart_horizontal.dart';
import '../allProducts/all_products.dart';
import '../models/category_model.dart';

class SubProductsScreen extends StatelessWidget {
  const SubProductsScreen({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // RoundedImage(
              //   imageURL: TImages.banner4,
              //   width: double.infinity,
              //   applyImageRadius: true,
              // ),
              // const SizedBox(height: TSizes.spaceBtwSections),

              FutureBuilder(
                future: CategoryController.instance.findSubCategories(
                  categoryId: category.id,
                ),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (asyncSnapshot.hasError) {
                    return Center(child: Text('Error: ${asyncSnapshot.error}'));
                  }

                  if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  List<CategoryModel> subCategories = asyncSnapshot.data!;

                  return ListView.builder(
                    itemCount: subCategories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final subCategory = subCategories[index];
                      return Column(
                        children: [
                          SectionHeading(
                            title: subCategory.name,
                            showActionButton: true,
                            onPressed: () {
                              Get.to(
                                () => AllProducts(
                                  title: category.name,
                                  futureMethod: ProductController.instance
                                      .getProductsForCategory(
                                        subCategory.id,
                                        limit: -1,
                                      ),
                                ),
                              );
                            },
                          ),
                          // const SizedBox(height: TSizes.spaceBtwItems),
                          SizedBox(
                            height: 120,
                            child: FutureBuilder(
                              future: ProductController.instance
                                  .getProductsForCategory(
                                    subCategory.id,
                                    limit: 4,
                                  ),
                              builder: (context, asyncSnapshot) {
                                if (asyncSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (asyncSnapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      'Error: ${asyncSnapshot.error}',
                                    ),
                                  );
                                }

                                if (!asyncSnapshot.hasData ||
                                    asyncSnapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text('No products found'),
                                  );
                                }
                                final products = asyncSnapshot.data!;
                                return ListView.separated(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        width: TSizes.spaceBtwItems * 1.5,
                                        color: Colors.white,
                                      ),
                                  itemBuilder: (context, index) =>
                                      ProductCartHorizontal(
                                        product: products[index],
                                      ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

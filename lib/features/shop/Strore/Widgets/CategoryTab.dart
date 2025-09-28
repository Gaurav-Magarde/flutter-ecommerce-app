import 'package:clone_shopping/common/widgets/products/product_card/productCardVertical.dart';
import 'package:clone_shopping/features/shop/Strore/Widgets/category_brands.dart';
import 'package:clone_shopping/features/shop/controllers/product_controller/product_controller.dart';
import 'package:clone_shopping/features/shop/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/BrandCard/brands_showCase.dart';
import '../../../../common/widgets/texts/SectionHeading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../home/widgets/GridView.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});


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
              CategoryBrands(category: CategoryModel.empty,),
              const SizedBox(height: TSizes.spaceBtwItems),
              SectionHeading(
                title: 'You may like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              GridViewLayout(
                itemCount: controller.featuredProducts.length,
                itemBuilder: (BuildContext context, index) {
                  return ProductCartVertical(
                    title: controller.featuredProducts[index].title,
                    image: controller
                        .featuredProducts[index]
                        .productVariations[0]
                        .image,
                    price: controller
                        .featuredProducts[index]
                        .productVariations[0]
                        .price,
                    salePrice: controller
                        .featuredProducts[index]
                        .productVariations[0]
                        .salePrice,
                    productId: controller.featuredProducts[index].id,
                    brandName:
                        controller.featuredProducts[index].brand?.name ?? " ", onCartTap: () {  },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
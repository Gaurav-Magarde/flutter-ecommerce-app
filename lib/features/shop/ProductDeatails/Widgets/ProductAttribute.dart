import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/features/shop/controllers/product_controller/variation_controller.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/chip/choiceChip.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/attribute_controller.dart';
import '../../models/product_model.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final variationController = Get.find<VariationController>(tag: product.id);
    final attributeController = Get.find<AttributeController>(tag: product.id);
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Obx(() {

              Wrap(
                spacing: 8,
                children: [
                  SectionHeading(title: "Size"),
                  SizedBox(height: TSizes.spaceBtwItems),
                ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: [
                SectionHeading(title: "Color"),
                SizedBox(height: TSizes.spaceBtwItems),


              ],
            ),
          ],
        ),
      ],
    );
  }
}

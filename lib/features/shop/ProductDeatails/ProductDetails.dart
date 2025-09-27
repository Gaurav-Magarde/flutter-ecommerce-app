import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/sizes.dart';
import '../Product_Reviews/ProductReviews.dart';
import '../checkout/Controller/chckout_controller.dart';
import '../checkout/checkout_screen.dart';
import '../controllers/attribute_controller.dart';
import '../controllers/product_controller/variation_controller.dart';
import '../models/cart_model/CartModel.dart';
import '../models/product_model.dart';
import 'Widgets/BottomCartWidget.dart';
import 'Widgets/ProductAttribute.dart';
import 'Widgets/ProductImageSlider.dart';
import 'Widgets/ProductMetaData.dart';
import 'Widgets/RatingAndShare.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final variationController = Get.put(VariationController(), tag: product.id);
    final attributeController = Get.put(
      AttributeController(product: product),
      tag: product.id,
    );
    Get.lazyPut(()=>CheckoutController());
    variationController.fetchAllVariations(product);
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image Slider
            ProductImageSlider(product: product),

            ///Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  ///Rating And Share
                  RatingAndShare(product: product),

                  ///Product MetaData
                  ProductMetaData(product: product),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  ///Product Attributes
                  ProductAttributes(product: product),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///CheckOut Button
                  Obx(()=>SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final itemToCheckOut = CartModel.fromProduct(
                          product,
                          qty: 1,
                          variation:
                              variationController.selectedVariation.value,
                        );
                        CheckoutController.instance.selectedCartItems.value = [
                          itemToCheckOut,
                        ];
                        CheckoutController.instance.calculateTotal();
                        Get.to(() => const CheckOutScreen());
                      },
                      child:  Text("Buy Now ₹${variationController.selectedVariation.value.salePrice.toInt()}")),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///Description
                  SectionHeading(title: "Description"),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ReadMoreText(
                    variationController.selectedVariation.value.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    textAlign: TextAlign.start,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "show less",
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  const Divider(),

                  Row(
                    children: [
                      SectionHeading(title: "Reviews(${product.reviews})"),
                      Spacer(),
                      IconButton(
                        onPressed: () =>
                            Get.to(() => const ProductReviewScreen()),
                        icon: Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

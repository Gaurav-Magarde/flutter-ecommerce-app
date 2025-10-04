import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_shopping/features/shop/models/product_model.dart';
import 'package:clone_shopping/features/shop/models/product_variation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../ WishList/Controllers/wishlist_controller.dart';
import '../../../ WishList/Model/wishlist_model.dart';
import '../../../../common/widgets/CurvedEdges/widget/customEdgeWIdget.dart';
import '../../../../common/widgets/appbar/customAppBar.dart';
import '../../../../common/widgets/container/TCircularIcon.dart';
import '../../../../common/widgets/images/CirculaImage.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product_controller/product_controller.dart';
import '../../controllers/product_controller/variation_controller.dart';
import 'full_screen_image.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final VariationController variationController = Get.find(tag: product.id);
    List<ProductVariationModel> variation = variationController.variations;
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TCurvedEdgeWidget(
          widget: Container(
            color: dark ? TColors.black : TColors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                          Get.to(()=>FullScreenImage(image :variationController
                              .selectedVariation
                              .value
                              .image));
          },

                      child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            TSizes.productImageRadius * 2,
                          ),
                          child: Center(
                            child: Obx(
                              () => CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                imageUrl: variationController
                                    .selectedVariation
                                    .value
                                    .image,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TAppBar(
                      showBackArrow: true,
                      actions: [
                        Obx(() {
                          final isFavourite = WishListController.instance.wishListId.contains(product.id);
                          return TCircularIcon(
                            onPressed: () {
                              final flag = WishListController.instance;
                              flag.toggleWishList(
                                product: product,
                                variation:
                                    variationController.selectedVariation.value,
                              );
                            },
                            icon: Iconsax.heart5,
                            iconColor: isFavourite ? Colors.red : TColors.white,
                            color: Colors.transparent,
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Divider(color: Colors.blueGrey, thickness: 2.5),

        Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal:  TSizes.spaceBtwSections),
            //   child: SectionHeading(title: "Variations",),
            // ),
            SizedBox(height: TSizes.spaceBtwItems / 1.2),
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.spaceBtwItems,
                ),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: variation.length,
                  itemBuilder: (_, index) => Obx(() {
                    final selected =
                        variationController.selectedVariation.value ==
                        variation[index];
                    return CircularImage(
                      padding: EdgeInsets.all(2),
                      fit: BoxFit.cover,
                      isNetworkImage: true,
                      width: 70,
                      imageURL: variation[index].image,
                      applyImageRadius: true,
                      onTap: () {
                        variationController.selectedVariation.value =
                            variation[index];
                      },
                      // applyImageRadius: true,
                      borderRadius: TSizes.cardRadiusSm,
                      backGroundColor: dark ? TColors.black : TColors.white,
                      border: Border.all(
                        color: selected ? TColors.primary : Colors.grey,
                        width: selected ? 2.5 : 0.9,
                      ),
                    );
                  }),

                  separatorBuilder: (_, __) =>
                      SizedBox(width: TSizes.spaceBtwItems),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

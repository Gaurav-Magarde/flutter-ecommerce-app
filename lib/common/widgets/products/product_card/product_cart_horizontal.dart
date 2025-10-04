import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/images/RoundedImage.dart';
import 'package:clone_shopping/common/widgets/texts/BrandTitleTextVerified.dart';
import 'package:clone_shopping/features/%20WishList/Controllers/wishlist_controller.dart';
import 'package:clone_shopping/features/shop/ProductDeatails/ProductDetails.dart';
import 'package:clone_shopping/features/shop/home/HomeScreen.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product_controller/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/Shadows.dart';

class ProductCartHorizontal extends StatelessWidget {
  const ProductCartHorizontal({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final salePercentage = ProductController.instance.getProductSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = THelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: (){
        Get.to(()=>ProductDetails(product: product,));
      },
      child: Container(
        width: 310,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalShadowStyle],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.black : TColors.softGrey,
        ),
        child: Row(
          children: [
            ///  Thumbnail
            TRoundedContainer(
              height: 120,
              width: 120,
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  RoundedImage(
                    height: 118,
                    width: 118,
                    color: dark ? TColors.dark : TColors.white,
                    imageURL: product.thumbnail,
                    applyImageRadius: true,
                  ),

                  Positioned(
                    top: 10,
                    child: TRoundedContainer(
                      backgroundColor: TColors.secondary,
                      child: Text(
                        salePercentage ?? "0",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 27,
                    child: InkWell(
                      onTap: (){
                        WishListController.instance.toggleWishList(
                          product: product,
                          variation: product.productVariations[0],
                        );
                      },
                      child: TRoundedContainer(
                        height: 5,
                        width: 4,
                        child: Obx(() {
                          WishListController.instance.wishListId;
                          bool isWishListed = WishListController.instance
                              .isWishListed(product.id);

                          return IconButton(
                            onPressed: () {},
                            icon: Icon(Iconsax.heart5),
                            color:  isWishListed ? Colors.redAccent : Colors.white,
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Details
            SizedBox(
              height: 120,
              width: 172,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(TSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Description
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.labelLarge,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 3.3),

                        /// Brand Verified
                        TBrandTitleWithVerifiedIcon(
                          title: product.brand?.name ?? "",
                        ),
                        // const Spacer(),

                        ///Price and To cart
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "₹${product.price.toInt().toString()}",
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .apply(
                                        fontWeightDelta: 5,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                                Text(
                                  "₹${product.salePrice.toInt().toString()}",
                                  style: Theme.of(context).textTheme.titleMedium!
                                      .apply(fontWeightDelta: 5),
                                ),
                              ],
                            ),

                            /// Add to cart
                            Container(
                              decoration: BoxDecoration(
                                color: TColors.dark,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(TSizes.cardRadiusMd),
                                  bottomRight: Radius.circular(
                                    TSizes.cardRadiusMd,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(Icons.add, color: TColors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

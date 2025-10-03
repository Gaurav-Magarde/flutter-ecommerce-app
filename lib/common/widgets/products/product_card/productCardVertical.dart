import 'package:clone_shopping/common/widgets/images/RoundedImage.dart';
import 'package:clone_shopping/common/widgets/texts/BrandTitleTextVerified.dart';
import 'package:clone_shopping/features/%20WishList/Controllers/wishlist_controller.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product_controller/product_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/Shadows.dart';
import '../../TCircularContainer/TCircularContainer.dart';
import '../../texts/productTitleText.dart';

class ProductCartVertical extends StatelessWidget {
  const ProductCartVertical({
    super.key,
    required this.image,
    required this.title,
    this.price,
    this.salePrice,
    this.onTap,
    required this.productId,
    required this.brandName,
    this.onFavouriteTap,
    required this.onCartTap,
  });

  final String image;
  final String title;
  final double? price;
  final double? salePrice;
  final Function()? onTap;
  final Function()? onFavouriteTap;
  final String productId;
  final String brandName;
  final Function()? onCartTap;
  @override
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final salePercentage =
        (price != null && salePrice != null && salePrice! > 0)
        ? Get.find<ProductController>().getProductSalePercentage(
            price!,
            salePrice!,
          )
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(TSizes.sm / 2),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalShadowStyle],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Thumbnail, Wishlist, Sale Tag --
            Stack(
              children: [
                RoundedImage(
                  height: 160,
                  width: double.infinity,
                  imageURL: image,
                  isNetworkImage: true,
                  applyImageRadius: true,
                ),

                // -- Sale Tag --
                if (salePercentage != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      height: 18,
                      width: 28,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(TSizes.sm)
                      ),
                      child: Center(
                        child: Text(
                          "$salePercentage %",
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                // -- Favourite Icon --
                Positioned(
                  top: 0,
                  right: 0,
                  child: Obx(() {
                    return IconButton(
                      onPressed: onFavouriteTap,
                      icon: Icon(
                        Iconsax.heart5,
                        color:
                            WishListController.instance.isWishListed(productId)
                            ? Colors.red
                            : TColors.white,
                      ), //Favorite Icon
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            // -- Details --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Title --
                  ProductTitleText(text: title, isSmall: true),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  // -- Brand --
                  TBrandTitleWithVerifiedIcon(title: brandName),
                ],
              ),
            ),

            //
            const Spacer(),

            //  Price & Add to Cart button
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // -- Price --
                  if (price != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (salePrice != null && salePrice! > 0)
                          Text(
                            price.toString(),
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        Text(
                          (salePrice != null && salePrice! > 0
                                  ? salePrice!
                                  : price!)
                              .toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                  const Spacer(),

                  // -- Add to Cart Button --
                  Container(
                    decoration: const BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      ),
                    ),
                    child: IconButton(
                      onPressed: onCartTap,
                      icon: const Icon(Iconsax.add, color: TColors.white),
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

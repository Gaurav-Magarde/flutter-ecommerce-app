import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/images/RoundedImage.dart';
import 'package:clone_shopping/common/widgets/texts/BrandTitleTextVerified.dart';
import 'package:clone_shopping/utils/constants/image_strings.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/Shadows.dart';

class ProductCartHorizontal extends StatelessWidget {
  const ProductCartHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
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
                color: dark ? TColors.dark : TColors.white,
                  imageURL: TImages.productImage1,
                  applyImageRadius: true,
                ),

                Positioned(
                  top: 10,
                  child: TRoundedContainer(
                    backgroundColor: TColors.secondary,
                    child: Text(
                      " 54% ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 27,
                  child: TRoundedContainer(
                    height: 5,
                    width: 4,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Iconsax.heart5),
                      color: Colors.redAccent,
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
                        "Green Adidas Air 2 shoes accent blue",
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 3.3),

                      /// Brand Verified
                      TBrandTitleWithVerifiedIcon(title: 'Adidas'),
                      // const Spacer(),

                      ///Price and To cart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$146",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.apply(fontWeightDelta: 5),
                          ),

                          /// Add to cart
                          Container(
                            decoration: BoxDecoration(
                              color: TColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight:  Radius.circular(TSizes.cardRadiusMd)
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(Icons.add,color: TColors.white,),
                            ),
                          )
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
    );
  }
}

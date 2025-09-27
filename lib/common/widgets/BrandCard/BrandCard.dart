import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../images/CirculaImage.dart';
import '../texts/BrandTitleTextVerified.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.showBorder, this.onTap, this.borderColor = Colors.black, this.borderWidth =0, this.backgroundColor, required this.brand,
  });

  final bool showBorder;
  final double borderWidth ;
  final Color borderColor;
  final Color ? backgroundColor;
  final BrandModel  brand;
 final void Function() ? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        borderWidth: borderWidth,
        borderColor: borderColor ,
        height: 70,
        width: double.infinity,
        radius: 16,
        padding: const EdgeInsets.all(TSizes.sm),
        backgroundColor: backgroundColor ?? Colors.transparent,
        child: Row(
          children: [

            // Image
            Flexible(
              child: CircularImage(
                imageURL:
                brand.image,
                imageColor: dark
                    ? TColors.white
                    : TColors.black,
              ),
            ),

            // Brand Name and products
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                    // textColor:Colors.black,
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    "${brand.productsCount} Products",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.apply(color: TColors.black),
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

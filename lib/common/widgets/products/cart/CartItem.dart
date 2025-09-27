import 'package:clone_shopping/features/shop/controllers/Cart/cart_controller.dart';
import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_model/CartModel.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/RoundedImage.dart';
import '../../texts/BrandTitleTextVerified.dart';
import '../../texts/productTitleText.dart';

class CartItemWithoutButtons extends StatelessWidget {
  const CartItemWithoutButtons({
    super.key, required this.index, this.cartItems,
  });

  final int index;
  final CartModel? cartItems;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [

        RoundedImage(
          imageURL: controller.cartItems[index].image,
          isNetworkImage: true,
          isCached: true,
          padding: EdgeInsets.all(TSizes.sm),
          height: 60,
          width: 60,
          color: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),

        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBrandTitleWithVerifiedIcon(title: controller.cartItems[index].brand),
            Flexible(child: ProductTitleText(text:controller.cartItems[index].title,maxLines: 1,)),

            Text.rich(TextSpan(
                children: [
                   controller.cartItems[index].color != null ?
                     TextSpan(text: "Color : ",style: Theme.of(context).textTheme.bodySmall) :
                     const TextSpan(text: ""),
                  controller.cartItems[index].color != null ?
                  TextSpan(text: controller.cartItems[index].color,style: Theme.of(context).textTheme.bodyLarge)
                  : const TextSpan(text: ""),
                  controller.cartItems[index].size != null ?
                  TextSpan(text: "Size : ",style: Theme.of(context).textTheme.bodySmall) :
                  const TextSpan(text: ""),
                  controller.cartItems[index].size != null ?
                  TextSpan(text: controller.cartItems[index].size,style: Theme.of(context).textTheme.bodyLarge)
                      : const TextSpan(text: ""),
                ]
            ))
          ],
        )
      ],
    );
  }
}
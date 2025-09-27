import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../container/TCircularIcon.dart';

class CartAddRemoveProduct extends StatelessWidget {
  const CartAddRemoveProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 70),
        Row(
          children: [

            TCircularIcon(
              icon: Iconsax.minus,
              size: 12,
              iconColor: THelperFunctions.isDarkMode(context)
                  ? TColors.white
                  : TColors.black,
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGrey
                  : TColors.light,
            ),

            const SizedBox(width: TSizes.spaceBtwItems),
            Text("2", style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: TSizes.spaceBtwItems),

            TCircularIcon(
              size: 12,
              icon: Iconsax.add,
              height: 32,
              width: 32,
              iconColor: TColors.white,
              color: TColors.primary,
            ),

          ],
        ),
      ],
    );
  }
}

import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [

        SectionHeading(
          title: "Payment Method",
          buttonTitle: "change",
          onPressed: () {},
          showActionButton: true,
        ),

        const SizedBox(height: TSizes.spaceBtwItems/2),

        Row(

          children: [
            TRoundedContainer(
              height: 35,
              width: 60,
              backgroundColor: dark ? TColors.dark : TColors.white,
              padding: EdgeInsets.all(TSizes.sm),
              child: Image(image: AssetImage(TImages.paypal),fit: BoxFit.contain,),
            ),

            const SizedBox(height: TSizes.spaceBtwItems/2),
            Text("paypal",style: Theme.of(context).textTheme.bodyLarge,)

          ],
        )
        
      ],
    );
  }
}

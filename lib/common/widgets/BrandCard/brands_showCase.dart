
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../container/RoundedContainer.dart';
import 'BrandCard.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
  });


  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          //   Brand with product count
          //  const BrandCard(showBorder : false),

          Row(
            children:
            images.map((image) => brandTopProductImageWidget(image,context)).toList()
            ,
          )
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image,context){
    final bool dark = THelperFunctions.isDarkMode(context);
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: dark ? TColors.darkGrey : TColors.light,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const  EdgeInsets.only(right: TSizes.sm),
        child: Image(image: AssetImage(image),fit: BoxFit.contain,),
      ),
    );
  }
}
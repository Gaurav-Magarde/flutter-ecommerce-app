
import 'package:clone_shopping/features/shop/Brands/Widgets/brand_product.dart';
import 'package:clone_shopping/features/shop/Brands/brands.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../features/shop/controllers/brand_controller.dart';
import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../container/RoundedContainer.dart';
import 'BrandCard.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images, required this.brand,
  });


  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final  controller  = Get.find<BrandController>();
    return InkWell(
      onTap:  (){
        Get.to(() => BrandProduct( title: brand.name, querySnapshot: controller.queryForBrand(brand.name)));
      },
      child: TRoundedContainer(
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
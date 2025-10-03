
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_shopping/common/widgets/texts/BrandTitleTextVerified.dart';
import 'package:clone_shopping/features/shop/Brands/Widgets/brand_product.dart';
import 'package:clone_shopping/features/shop/Brands/brands.dart';
import 'package:clone_shopping/utils/constants/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

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
              children:[
                TRoundedContainer(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap:  (){
                    Get.to(() => BrandProduct( title: brand.name, querySnapshot: controller.queryForBrand(brand.name)));

                    } ,
                    child: Column(
                      children: [

                        SizedBox(height : 60, child: CachedNetworkImage(imageUrl: brand.image,fit: BoxFit.contain,)),
                        SizedBox(height :TSizes.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(brand.name,style: Theme.of(context).textTheme.headlineMedium,),
                            SizedBox(width: 3,),
                            Icon(Iconsax.verify5, color: TColors.primary, size: TSizes.iconMd),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: TSizes.spaceBtwItems,)
                ,SizedBox(
                  height: 90,
                  width: 160,
                  child: ListView.builder(
                    itemCount: images.length,
                      shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(right : TSizes.spaceBtwItems),
                      child: brandTopProductImageWidget(images[index],context),
                    );
                  }),
                )
              ]


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
        height: 50,
        width: 50,
        // padding: EdgeInsets.symmetric(vertical: TSizes.md),
        backgroundColor: dark ? TColors.darkGrey : TColors.light,
        margin: const  EdgeInsets.only(right: TSizes.sm),
        child: Image(image: AssetImage(image),fit: BoxFit.contain,),
      ),
    );
  }
}
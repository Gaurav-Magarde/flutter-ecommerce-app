import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/common/widgets/texts/BrandTitleTextVerified.dart';
import 'package:clone_shopping/common/widgets/texts/productTitleText.dart';
import 'package:clone_shopping/features/shop/controllers/product_controller/variation_controller.dart';
import 'package:clone_shopping/features/shop/models/product_model.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product_controller/product_controller.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product,});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final  variationController = Get.find<VariationController>(tag: product.id);
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ///Pricing And Off
       Obx((){

        final salePercent = variationController.selectedVariation.value.salePrice > 0 ? controller.getProductSalePercentage(variationController.selectedVariation.value.price, variationController.selectedVariation.value.salePrice) : null;
         return  Row(
           children: [
             TRoundedContainer(
               radius: TSizes.sm,
               backgroundColor: TColors.secondary.withAlpha(200),
               padding: EdgeInsets.symmetric(horizontal: TSizes.sm,vertical: TSizes.xs,),
               child: Text(salePercent ?? "0%" ,style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
             ),
             const SizedBox(width: TSizes.spaceBtwItems,),
             Text("\$${variationController.selectedVariation.value.price}",style: Theme.of(context).textTheme.labelLarge!.apply(decoration: TextDecoration.lineThrough)),
             SizedBox(width: TSizes.spaceBtwItems/2,),
             Text("\$${variationController.selectedVariation.value.salePrice}",style: Theme.of(context).textTheme.titleLarge),

           ],
         );
       })
        ,

        ///Description
        SizedBox(height: TSizes.spaceBtwItems/1.5,),
        ProductTitleText(text: variationController.selectedVariation.value.description),
        SizedBox(height: TSizes.spaceBtwItems/1.5,),

        ///iS In Stock
       Obx(
         (){
           final stock = controller.getProductStockStatus(variationController.selectedVariation.value.stock);

           return Row(
             children: [
               ProductTitleText(text: "Status"),
               SizedBox(width: TSizes.spaceBtwItems/2,),
               Text(stock,style: Theme.of(context).textTheme.titleLarge)

             ],
           );
         },
       ),

        ///Brand
        SizedBox(height: TSizes.spaceBtwItems/1.5,),
       if(product.brand != null) TBrandTitleWithVerifiedIcon(title: product.brand!.name,brandTextSize: TextSizes.large,textAlign: TextAlign.start,)

      ],

    );
  }
}

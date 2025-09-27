import 'package:clone_shopping/common/widgets/container/TCircularIcon.dart';
import 'package:clone_shopping/features/shop/models/product_model.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/Cart/cart_controller.dart';
import '../../controllers/product_controller/variation_controller.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final variationController = Get.find<VariationController>(tag: product.id);
    Get.lazyPut(() => CartController());
    RxInt quantity = 1.obs;
    return Container(
      height: 73,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: dark ? TColors.dark : TColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [


              GestureDetector(
                onTap: (){
                 if(quantity.value > 1) quantity.value--;
                },
                child: TCircularIcon(
                  radius: 40,
                  icon: Iconsax.minus,
                color: TColors.darkGrey,
                  iconColor: TColors.white,
                ),
              ),
              SizedBox(width : TSizes.spaceBtwItems),
              Obx((){
                return Text(quantity.value.toString(),style: Theme.of(context).textTheme.titleSmall,);
              }),
              SizedBox(width : TSizes.spaceBtwItems),
              GestureDetector(
                onTap: (){
                  quantity.value++;
                },
                child: TCircularIcon(
                  radius: 40,
                  icon: Iconsax.add,
                  color: TColors.dark,
                  iconColor: TColors.white,
                ),
              ),

            ],
          ),
              SizedBox(width: 100, child: ElevatedButton(onPressed: (){
                 if(!CartController.instance.isLoading.value) {
                   CartController.instance.addToCart(product: product, variation: variationController.selectedVariation.value, quantity: quantity.value);
                 }


              },style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary
              ), child: Obx(() {
                if(CartController.instance.isLoading.value){
                  return CircularProgressIndicator(color: TColors.white,);
                }
               return Text("Add to cart");
              } )),)


        ],
      ),
    );
  }
}

import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/features/shop/checkout/Controller/chckout_controller.dart';
import 'package:clone_shopping/features/shop/checkout/checkout_screen.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/shimmer/cart_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/Cart/cart_controller.dart';
import 'cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});



  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    Get.lazyPut(() => CheckoutController());
    return Scaffold(
      appBar: TAppBar(title: Text("cart"), showBackArrow: true),

      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child:
        Obx((){
          if(controller.isLoading.value){
            return CartShimmer();
          }

          if(controller.cartItems.isEmpty) {
            return Center(child: Text("No Items in Cart"));
           }

          return CartItems(showAddRemoveButtons: true
            ,cartItems: controller.cartItems, showBuyNowButton: true
            ,);
          }
         ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace,
          vertical: TSizes.defaultSpace / 2,
        ),
        child: ElevatedButton(
          onPressed: () {
            final itemsToCheckOut = controller.cartItems;
            CheckoutController.instance.selectedCartItems.value = itemsToCheckOut;
            CheckoutController.instance.calculateTotal();
            Get.to(() => const CheckOutScreen());
          },
          child: Obx(() => Text("Checkout \₹${controller.totalPrice}")),
        ),
      ),
    );
  }
}

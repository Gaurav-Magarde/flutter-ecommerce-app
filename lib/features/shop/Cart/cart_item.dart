import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_shopping/common/widgets/texts/BrandTitleTextVerified.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../checkout/Controller/chckout_controller.dart';
import '../checkout/checkout_screen.dart';
import '../controllers/Cart/cart_controller.dart';
import '../models/cart_model/CartModel.dart';

class CartItems extends StatelessWidget{
  const CartItems({
    super.key,
    required this.showAddRemoveButtons,
    required this.cartItems,
    required this.showBuyNowButton,
  });

  final bool showAddRemoveButtons;
  final bool showBuyNowButton;
  final List<CartModel> cartItems;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(
      () => ListView.separated(
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        shrinkWrap: true,
        itemCount: cartItems.length,
        itemBuilder: (_, index) => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      SizedBox(
                        width: 80,
                        height: 120,
                        child: CachedNetworkImage(
                          imageUrl: cartItems[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwItems,),
                      Text(
                        "Qty :- ${cartItems[index].quantity}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                // if (showAddRemoveButtons)

                // CartAddRemoveProduct(),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: TSizes.spaceBtwItems/2,),

                      Text(
                        cartItems[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems/2,),

                      TBrandTitleWithVerifiedIcon(title: cartItems[index].brand)
                    ],
                  ),
                      SizedBox(height: TSizes.spaceBtwItems/2,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹ ${cartItems[index].price}",
                            style: Theme.of(context).textTheme.labelLarge!
                                .apply(color: TColors.black)
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            " ₹ ${cartItems[index].salePrice}",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .apply(color: TColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showBuyNowButton)
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        final controller = CartController.instance;
                        controller.removeFromCart(cartItems[index].productId);
                      },
                      child: Text(
                        "Remove",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.apply(color: TColors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 32.0,
                        ),
                      ),

                      onPressed: () {
                        final itemToCheckOut = cartItems.firstWhere(
                          (item) =>
                              item.productId == cartItems[index].productId,
                        );
                        CheckoutController.instance.selectedCartItems.value = [
                          itemToCheckOut,
                        ];
                        CheckoutController.instance.calculateTotal();
                        Get.to(() => const CheckOutScreen());
                      },
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.apply(color: TColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../features/shop/controllers/Cart/cart_controller.dart';
import '../../../../../utils/constants/colors.dart';

class CartCounterWidget extends StatelessWidget {
  const CartCounterWidget({
    super.key,
    required this.onPressed,
    required this.color,
  });
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag, color: color),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: TColors.grey.withAlpha(100),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.cartItems.length.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

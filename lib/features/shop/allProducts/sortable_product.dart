import 'package:clone_shopping/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../ WishList/Controllers/wishlist_controller.dart';
import '../../../common/widgets/products/product_card/productCardVertical.dart';
import '../../../utils/constants/sizes.dart';
import '../ProductDeatails/ProductDetails.dart';
import '../controllers/Cart/cart_controller.dart';
import '../controllers/all_product_controller.dart';
import '../home/widgets/GridView.dart';

class SortableProduct extends StatelessWidget {
  const SortableProduct({super.key, required this.productList});

  final List<ProductModel> productList;
  @override
  Widget build(BuildContext context) {

    final controller = Get.find<AllProductsController>();
    controller.assignProducts(productList);

    return Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),

          items: ["Name", "Higher Price", "Lower Price", "sale"]
              .map((sel) => DropdownMenuItem(value: sel, child: Text(sel)))
              .toList(),
          value: controller.selectedSort.value,
          onChanged: (val) {
            controller.sortProducts(val.toString());

    },
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(
    ()=> GridViewLayout(
            itemCount: controller.sortedProducts.length,
            itemBuilder: (BuildContext context, index) {
              final product = controller.sortedProducts[index];
              final cheapestVariation = product.cheapestVariation;
              if (cheapestVariation == null) {
                return const SizedBox(); // Safety check
              }

              return ProductCartVertical(
                title: product.title,
                image: product
                    .thumbnail,
                price:
                product.price,
                salePrice: product.salePrice,
                productId: product.id,
                brandName: product.brand?.name ?? "",
                onFavouriteTap: () {
                  WishListController.instance.toggleWishList(
                    product: product,
                    variation:
                    cheapestVariation, // <-- Sahi variation use karo
                  );
                },
                onTap: () {
                  Get.to(() => ProductDetails(product: product));
                },
                onCartTap: () {
                  CartController.instance.addToCart(
                    product: product,
                    variation: cheapestVariation,
                    quantity: 1,
                  );
                },
              );
            }
          ),
        ),
      ],
    );
  }
}

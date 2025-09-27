import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/products/product_card/productCardVertical.dart';
import 'package:clone_shopping/features/shop/home/HomeScreen.dart';
import 'package:clone_shopping/features/shop/home/widgets/GridView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/sizes.dart';
import 'Controllers/wishlist_controller.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishListController>();
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Wishlist",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(const HomeScreen()),
            icon: const Icon(Iconsax.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
                Obx(() {
                  if(controller.isLoading.value){
                return Center(
                  child: CircularProgressIndicator(),
                );
                  }

                  if (controller.wishList.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/images/animations/53207-empty-file.json',
                          ),
                          SizedBox(height: TSizes.defaultSpace,),
                          Text("Your wishlist is empty !",style: Theme.of(context).textTheme.headlineSmall,),
                        ],
                      )
                    );
                  }
                  return Obx(
                    () => GridViewLayout(
                      mainAxisExtent: 270,
                      itemCount: controller.wishList.length,
                      itemBuilder: (BuildContext context, index) {
                        final wishLisItem = controller.wishList[index];
                        return ProductCartVertical(
                          image: wishLisItem.image,
                          title: wishLisItem.title,
                          productId: wishLisItem.productId,
                          brandName: wishLisItem.brand,
                          onCartTap: () {
                            // controller.removeFromWishList(wishLisItem);
                          },
                          onFavouriteTap: () {
                            controller.removeFromWishList(wishLisItem.productId);
                          },
                        );
                      },
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clone_shopping/features/shop/ProductDeatails/ProductDetails.dart';
import 'package:clone_shopping/features/shop/home/widgets/AppBarWidget.dart';
import 'package:clone_shopping/features/shop/home/widgets/GridView.dart';
import 'package:clone_shopping/features/shop/home/widgets/HomeCategories.dart';
import 'package:clone_shopping/features/shop/home/widgets/PromoSlider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ WishList/Controllers/wishlist_controller.dart';
import '../../../../../common/widgets/CurvedEdges/widget/customEdgeWIdget.dart';
import '../../../../../common/widgets/container/PrimaryHeaderContainer.dart';
import '../../../../../common/widgets/container/SearchContainer.dart';
import '../../../../../common/widgets/products/product_card/productCardVertical.dart';
import '../../../../../common/widgets/texts/SectionHeading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/shimmer/product_shimmer.dart';
import '../allProducts/all_products.dart';
import '../controllers/Cart/cart_controller.dart';
import '../controllers/product_controller/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    Get.put(CartController());
    Get.put(WishListController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TCurvedEdgeWidget(
              widget: HeaderContainerWidget(
                height: 350,
                child: Column(
                  children: [
                    // App bar Widget
                    const AppBarWidget(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    //Item Search bar
                    SearchBarItem(),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    Padding(
                      padding: EdgeInsets.only(left: TSizes.defaultSpace),
                      child: Column(
                        children: [
                          // Section Heading
                          SectionHeading(
                            title: 'Popular Categories',
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),

                          /// Popular [HomeScreen] for home screen
                          const HomeCategories(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Promo Slider Banner
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  SectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: "Popular Products",
                        query: FirebaseFirestore.instance
                            .collection('Products')
                            .where('IsFeatured', isEqualTo: true)
                            .where("NoOfProductVariations", isGreaterThan: 0)
                            .limit(6),
                      ),
                    ),
                    showActionButton: true,
                  ),
                  // const SizedBox(height: TSizes.spaceBtwSections),

                  // Grid for showing product
                  Obx(() {
                    if (controller.isLoading.value) {
                      return ProductShimmer();
                    }

                    if (controller.featuredProducts.isEmpty) {
                      return const Text("No Products Found");
                    }

                    return GridViewLayout(
                      mainAxisExtent: 275,
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) {
                        final product = controller.featuredProducts[index];

                        final cheapestVariation = product.cheapestVariation;
                        if (cheapestVariation == null) {
                          return const SizedBox(); // Safety check
                        }

                        return ProductCartVertical(
                          title: product.title,
                          image: product
                              .thumbnail, // Yeh pehle se hi cheapest se aa raha hai
                          price:
                              product.price, // Yeh bhi cheapest se aa raha hai
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
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

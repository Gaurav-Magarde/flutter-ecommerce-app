import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/BrandCard/BrandCard.dart';
import '../../../common/widgets/appbar/customAppBar.dart';
import '../../../common/widgets/container/SearchContainer.dart';
import '../../../common/widgets/products/cart/products/CartCounterWidget.dart';
import '../../../common/widgets/texts/SectionHeading.dart';
import '../../../utils/constants/sizes.dart';
import '../Brands/Widgets/brand_product.dart';
import '../Brands/brands.dart';
import '../controllers/brand_controller.dart';
import '../home/widgets/GridView.dart';
import '../home/widgets/tabBar.dart';
import 'Widgets/CategoryTab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final brandController = Get.put(BrandController());
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text("Store"),
          actions: [CartCounterWidget(onPressed: () {}, color: Colors.black)],
        ),
        body: NestedScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (_, innerBoxISScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 430,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      SearchBarItem(
                        text: "search in stores",
                        border: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      SectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const BrandsScreen()),
                        showActionButton: true,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections / 2),

                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (brandController.featuredBrands.isEmpty) {
                          return const Center(
                            child: Text("No Brands Found"),
                          );
                        }

                        return GridViewLayout(
                          mainAxisExtent: 80,
                          itemCount: brandController.featuredBrands.length,
                          itemBuilder: (BuildContext context, index) {
                            return BrandCard(
                              onTap: (){
                                Get.to(() => BrandProduct( title: brandController.allBrands[index].name, querySnapshot: brandController.queryForBrand(brandController.allBrands[index].name)));
                              },
                              showBorder: true,
                              borderColor: dark ? TColors.white : TColors.black,
                              brand: brandController.featuredBrands[index],
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: [
                    Tab(child: Text("Sports")),
                    Tab(child: Text("Furniture")),
                    Tab(child: Text("Electronics")),
                    Tab(child: Text("Clothes")),
                    Tab(child: Text("Cosmetics")),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
              CategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}

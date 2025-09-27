import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/features/shop/home/widgets/GridView.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/BrandCard/BrandCard.dart';
import '../controllers/brand_controller.dart';
import 'Widgets/brand_product.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text("Brands")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SectionHeading(title: "Brands"),
              SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {

                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.allBrands.isEmpty) {
                  return const Center(
                    child: Text("No Brands Found"),
                  );
                }

                return GridViewLayout(
                  mainAxisExtent: 80,
                  itemCount: controller.allBrands.length,
                  itemBuilder: (BuildContext context, index) => BrandCard(
                    onTap: (){
                      Get.to(() => BrandProduct( title: controller.allBrands[index].name, querySnapshot: controller.queryForBrand(controller.allBrands[index].name)));
                    },
                    backgroundColor: TColors.white,
                    showBorder: true,
                    borderColor: dark ? TColors.white : TColors.black,
                    borderWidth: 1,
                    brand: controller.allBrands[index],
                  ),
                );
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}

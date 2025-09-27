import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/features/shop/controllers/product_controller/product_controller.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../SettingMenuTile.dart';

class LoadDataScreen extends StatelessWidget {
  const LoadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(" UpLoad Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          child: Column(
            children: [
              SettingMenuTile(
                title: "Upload Banner",
                leadingIcon: Icons.card_giftcard_outlined,
                subTitle: "upload banners to firebase",
                onTap: (){}
              ),
              SizedBox(height: TSizes.spaceBtwItems,),


              SettingMenuTile(
                title: "Upload Product",
                leadingIcon: Icons.card_giftcard_outlined,
                subTitle: "upload products to firebase",
                onTap: (){
                  productController.uploadProduct();
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

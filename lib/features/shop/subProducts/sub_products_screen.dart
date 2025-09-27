import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/images/RoundedImage.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/products/product_card/product_cart_horizontal.dart';
import '../../../utils/constants/image_strings.dart';

class SubProductsScreen extends StatelessWidget {
  const SubProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text("sports shirts"), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              RoundedImage(
                imageURL: TImages.banner4,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Column(
                children: [
                  SectionHeading(
                    title: "sports shirts",
                    showActionButton: true,
                    onPressed: () {},
                  ),
                  // const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          Container(width: TSizes.spaceBtwItems * 1.5,color: Colors.white,),
                      itemBuilder: (context, index) =>
                          const ProductCartHorizontal(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

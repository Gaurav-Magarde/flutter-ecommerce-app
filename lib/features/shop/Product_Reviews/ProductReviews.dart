import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import 'TOverallRating.dart';
import 'UserReviewCard.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text("Reviews & Ratings"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              /// Ratings
              Text("Rating and reviews are from people who use the same products .and from Real users not fake bots"),
              const SizedBox(height: TSizes.spaceBtwItems,),
              const TOverallRating(),
              RatingBarIndicator(
                  itemSize: 20,
                  rating: 4.1,
                  itemBuilder: (_,__)=>Icon(Iconsax.star1,color: TColors.secondary,)),
              Text("1,254"),

              /// Reviews
              SizedBox(height: TSizes.spaceBtwItems,),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),


            ],
          ),

        ),
      ),
    );
  }
}



import 'package:clone_shopping/common/widgets/container/RoundedContainer.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark  =  THelperFunctions.isDarkMode(context);
    return Column(
      children: [

        ///Reviewed person Profile
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage1),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text("john Doe", style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),


        ///Date and how much rated
        Row(
          children: [
            RatingBarIndicator(
              rating: 3.7,
              itemSize: 15,
              itemBuilder: (_, __) =>
                  Icon(Icons.star_outlined, color: TColors.secondary),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text("20 Nov 2018", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        ReadMoreText(
          "The product was amazing and i am using for a long it's quality is superb as compare to another similar Items",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: "show less",
          trimCollapsedText: "show more",
          moreStyle: TextStyle(fontSize: 14,color: TColors.dark,fontWeight: FontWeight.bold),
          lessStyle: TextStyle(fontSize: 14,color: TColors.dark,fontWeight: FontWeight.bold)
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Nike", style: Theme.of(context).textTheme.titleLarge),
                      Icon(
                        Icons.verified, // ya Icons.check_circle
                        color: Color(0xffa660e4),
                        size: 20,
                      )
                    ],
                  ),
                  Text("21 Nov 2018", style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
              ReadMoreText(
                  "Thanks for buying our products and review us Keep Buying",
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: "show less",
                  trimCollapsedText: "show more",
                  moreStyle: TextStyle(fontSize: 14,color: TColors.dark,fontWeight: FontWeight.bold),
                  lessStyle: TextStyle(fontSize: 14,color: TColors.dark,fontWeight: FontWeight.bold)
              ),
            ],
          ),),
        )

      ],
    );
  }
}

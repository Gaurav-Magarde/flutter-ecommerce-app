import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color:  TColors.white,
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  SizedBox(
                    height: 15,
                    width: 55,
            
                  ),
                ],
              ),
            
            
            ),
          ),
        );
      },

    );
  }
}

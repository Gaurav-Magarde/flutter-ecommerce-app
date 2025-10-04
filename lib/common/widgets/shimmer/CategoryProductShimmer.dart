import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class CategoryProductShimmer extends StatelessWidget {
  const CategoryProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(width: .5, color: Colors.black),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Row(
              children: [
                // Shimmer for the 'Name' text line
                ShimmerBox(width: 80, height: 120),
                SizedBox(width: 24.0),
                // Shimmer for the 'Phone Number' text line
                ShimmerBox(width: 60, height: 90),
                SizedBox(width: 8.0),
                // Shimmer for the 'Address Line 1'
                ShimmerBox(width: 60, height: 90),
                  SizedBox(width: 8.0),

                ShimmerBox(width: 30, height: 90),
                SizedBox(width: 8.0),
                // Shimmer for the 'Address Line 2'

              ],
            ),
          ),
        );
  }
}


class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white, // This color doesn't matter, shimmer will cover it.
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class AddressShimmer extends StatelessWidget {
  const AddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer for the 'Name' text line
                  ShimmerBox(width: 70, height: 16),
                  SizedBox(height: 8.0),
                  // Shimmer for the 'Phone Number' text line
                  ShimmerBox(width: 90, height: 14),
                  SizedBox(height: 16.0),
                  // Shimmer for the 'Address Line 1'
                  ShimmerBox(width: 180, height: 14),
                  SizedBox(height: 8.0),
                  // Shimmer for the 'Address Line 2'
                  ShimmerBox(width: 180, height: 14),
                  SizedBox(height: 8.0),
                  // Shimmer for the 'City, Postal Code' line
                  ShimmerBox(width: 100, height: 14),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        itemCount: 3,
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
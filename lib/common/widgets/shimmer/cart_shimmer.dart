import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  TSizes.defaultSpace/2),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white60,
            child: Container(
              height: 90,
              color: Colors.cyanAccent,
              width: 100,
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

import 'package:flutter/cupertino.dart';

import '../../../../../../utils/constants/sizes.dart';

class GridViewLayout extends StatelessWidget {
  const                                                                                                                       GridViewLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 280,
    required this.itemBuilder,
  });
  final int itemCount;
  final double mainAxisExtent;
  final Widget Function(BuildContext context, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        crossAxisCount: 2,
      ),
      itemBuilder:  itemBuilder,
    );
  }
}

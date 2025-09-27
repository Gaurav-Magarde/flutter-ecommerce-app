import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor = TColors.white,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
      final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
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
              child: Center(
                child: Image(
                  fit: BoxFit.cover,
                  color: dark ? TColors.light : TColors.dark,
                  image: NetworkImage(image)
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
              height: 15,
              width: 55,
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: textColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

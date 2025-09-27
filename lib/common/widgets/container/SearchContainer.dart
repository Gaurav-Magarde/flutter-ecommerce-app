import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class SearchBarItem extends StatelessWidget {
  const SearchBarItem({
    super.key,
    this.text = "search in store",
    this.border = true,
    this.showBackground = true,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final bool border, showBackground;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: padding,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: border ? BorderRadius.circular(16) : null,
          color: showBackground
              ? dark
                    ? TColors.dark
                    : TColors.white
              : null,
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: dark ? TColors.darkGrey : TColors.grey),
            SizedBox(width: TSizes.spaceBtwItems),

            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hint: Text(text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

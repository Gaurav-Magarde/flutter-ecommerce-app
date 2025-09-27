import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class dividerLoginOrSignIn extends StatelessWidget {
  const dividerLoginOrSignIn({super.key, required this.dividerText});
    final String dividerText;
  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            indent: 60,
            endIndent: 5,
            thickness: 1,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColors.darkGrey : TColors.grey,
            indent: 5,
            endIndent: 60,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

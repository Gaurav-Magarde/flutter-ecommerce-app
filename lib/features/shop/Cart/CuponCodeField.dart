
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/container/RoundedContainer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CouponCodeField extends StatelessWidget {
  const CouponCodeField({
    super.key
  });



  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: EdgeInsets.only(
        right: TSizes.sm,
        left: TSizes.md,
        top: TSizes.sm,
        bottom: TSizes.sm,
      ),
      child: Row(
        children: [

          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                  hint: Text("Have a promo code? Enter here"),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none
              ),
            ),
          ),

          SizedBox(width: 80,
              child: ElevatedButton(onPressed: (){}, child: Text("Apply")))
        ],
      ),
    );
  }
}

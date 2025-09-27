import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/onBoardingController/controller_onboarding.dart';



class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark  = THelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: kBottomNavigationBarHeight,
      right: TSizes.defaultSpace,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: dark ? TColors.primary : TColors.black,
        ),
        onPressed: onBoardingController.instance.nextPage,
        child: Icon(Iconsax.arrow_right_3,color: Colors.white,),
      ),
    );
  }
}

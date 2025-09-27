
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

import '../../../controllers/onBoardingController/controller_onboarding.dart';

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(onPressed: onBoardingController.instance.skipPage, child: const Text("skip")),
    );
  }
}

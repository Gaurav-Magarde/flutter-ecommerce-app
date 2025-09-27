import 'package:clone_shopping/features/authentication/screens/onboarding/widgets/inBoardingPageIndicator.dart';
import 'package:clone_shopping/features/authentication/screens/onboarding/widgets/onBoardingNextButton.dart';
import 'package:clone_shopping/features/authentication/screens/onboarding/widgets/onBoardingPageview.dart';
import 'package:clone_shopping/features/authentication/screens/onboarding/widgets/onBoardingSkip.dart';
import 'package:clone_shopping/utils/constants/image_strings.dart';
import 'package:clone_shopping/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/onBoardingController/controller_onboarding.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});


  @override
  Widget build(BuildContext context) {
  final controller = Get.put(onBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: onBoardingController.instance.pageController,
            onPageChanged: onBoardingController.instance.updatePageIndicator,
            children: [
              const onBoardingPageview(
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
                image: TImages.onBoardingImage1,
              ),
              const onBoardingPageview(
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
                image: TImages.onBoardingImage2,
              ),
              const onBoardingPageview(
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
                image: TImages.onBoardingImage3,
              ),
            ],
          ),

          //   skip button
          const onBoardingSkip(),

          // smoothPageIndicator
          const onBoardingPageIndicator(),

          //   To next Page button
          const onBoardingNextButton(),
        ],
      ),
    );
  }
}


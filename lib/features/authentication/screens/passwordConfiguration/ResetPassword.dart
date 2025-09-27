import 'package:clone_shopping/features/authentication/screens/login/loginScreen.dart';
import 'package:clone_shopping/utils/constants/image_strings.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/forgotPassword/forgot_password.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Icons.clear))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          top: kToolbarHeight ,
        ),
        child: Column(
          children: [
            Image(
              image: AssetImage(TImages.deliveredEmailIllustration),
              width: THelperFunctions.screenWidth() * 0.6,
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            Text(
              TTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            Text(
              TTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(height: TSizes.spaceBtwItems * 2),

            const SizedBox(height: TSizes.spaceBtwItems),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(LoginScreen()),
                child: Text(TTexts.done),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => controller.resendPasswordResetEmail(email),
                child: Text(TTexts.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

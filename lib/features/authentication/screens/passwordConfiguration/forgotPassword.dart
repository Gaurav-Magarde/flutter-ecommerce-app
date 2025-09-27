import 'package:clone_shopping/utils/constants/text_strings.dart';
import 'package:clone_shopping/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/forgotPassword/forgot_password.dart';
import 'ResetPassword.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(ForgotPasswordController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: TSizes.defaultSpace,
          bottom: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
          top: kToolbarHeight,
        ),
        child: Column(
          children: [
            Text(
              TTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems * 2),
            Form(
            key: controller.forgotPasswordFormKey,
              
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.passwordResetEmail,
                child: const Text(TTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

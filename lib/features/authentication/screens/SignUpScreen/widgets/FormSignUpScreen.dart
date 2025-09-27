import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/constants/text_strings.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/SignUPCohntroller/sign_up_controller.dart';

class FormSignUPScreen extends StatelessWidget {
  const FormSignUPScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUPController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          /// first and last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) => TValidator.validateEmptyText(
                    TTexts.firstName,
                    controller.firstName.text,
                  ),
                  expands: false,
                  controller: controller.firstName,
                  decoration: InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),

              const SizedBox(width: TSizes.spaceBtwInputFields),

              Expanded(
                child: TextFormField(
                  validator: (value) => TValidator.validateEmptyText(
                    "LastName",
                    controller.lastName.text,
                  ),
                  expands: false,
                  controller: controller.lastName,
                  decoration: InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///userName
          TextFormField(
            validator: (value) => TValidator.validateEmptyText(
              "UserName",
              controller.userName.text,
            ),
            controller: controller.userName,
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Email
          TextFormField(
            validator: (val) => TValidator.validateEmail(controller.email.text),
            controller: controller.email,
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Phone No
          TextFormField(
            validator: TValidator.validatePhoneNumber,
            controller: controller.phoneNumber,
            expands: false,
            decoration: InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          ///Password
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              validator: (value) =>
                  TValidator.validatePassword(controller.password.text),
              expands: false,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(Iconsax.eye_slash),
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          Obx(
            () => Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Checkbox(
                    value: controller.privacyPolicyBox.value,
                    onChanged: (val) {
                      controller.privacyPolicyBox.value =
                          !controller.privacyPolicyBox.value;
                    },
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${TTexts.iAgreeTo} ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: TTexts.privacyPolicy,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' ${TTexts.and} ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: TTexts.termsOfUse,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signUp(),
              child: Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:clone_shopping/features/authentication/screens/passwordConfiguration/forgotPassword.dart';
import 'package:clone_shopping/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/login_controller.dart';
import '../../SignUpScreen/SignUpScreen.dart';

class FormLoginScreen extends StatelessWidget {
  const FormLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: TValidator.validateEmail,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Obx(
              ()=> TextFormField(
                controller: controller.password,
                validator: TValidator.validatePassword,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                  labelText: TTexts.password,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (val) {
                          controller.rememberMe.value = !controller.rememberMe.value;
                        },
                      ),
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(ForgotPassword()),
                  child: Text(TTexts.forgetPassword),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                    controller.signInWithEmailAndPassword();
                },
                child: Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                child: Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/SignUPCohntroller/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.email});

final String email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthenticationRepository.instance.logOut();
              AuthenticationRepository.instance.screenRedirect();
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const  EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                height: THelperFunctions.screenWidth() * 0.6,
                image: AssetImage(
                  "assets/images/animations/sammy-line-man-receives-a-mail.png",
                ),
              ),

              //   title and subtitle
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(
                email,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(()=> controller.checkEmailVerificationStatus());
                  },
                  child:const  Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    controller.sendEmailVerification();
                  },
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

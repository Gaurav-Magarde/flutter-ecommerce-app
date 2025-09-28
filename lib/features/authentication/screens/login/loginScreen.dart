 import 'package:clone_shopping/utils/constants/text_strings.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';
import 'Widgets/DividerLoginScreen.dart';
import 'Widgets/FormLoginScreen.dart';
import 'Widgets/googleFacebookSignUpImage.dart';
import 'Widgets/logoLoginScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [

              logoLoginScreen(),

              FormLoginScreen(),

              SizedBox(height: TSizes.spaceBtwItems,),


              dividerLoginOrSignIn(dividerText: TTexts.orSignInWith,),

              SizedBox(height: TSizes.spaceBtwItems,),

              googleSignUpImages(),

            ],
          ),
        ),
      ),
    );
  }
}





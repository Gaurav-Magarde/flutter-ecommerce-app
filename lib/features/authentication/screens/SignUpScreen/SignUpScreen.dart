
import 'package:clone_shopping/features/authentication/screens/SignUpScreen/widgets/FormSignUpScreen.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/customAppBar.dart';
import '../login/Widgets/DividerLoginScreen.dart';
import '../login/Widgets/googleFacebookSignUpImage.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(TTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),

                const SizedBox(height: TSizes.spaceBtwItems,),

                FormSignUPScreen(),

                const SizedBox(width: TSizes.spaceBtwItems,),

                dividerLoginOrSignIn(dividerText: TTexts.orSignUpWith,),

                const SizedBox(height: TSizes.spaceBtwItems,),

                googleSignUpImages(),
          ]
          ),
        ),
      ),
    );
  }
}

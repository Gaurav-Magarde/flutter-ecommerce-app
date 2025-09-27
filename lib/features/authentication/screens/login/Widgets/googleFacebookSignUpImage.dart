import 'package:clone_shopping/data/repositries/dataRepositries/reposetry_authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/login_controller.dart';

class googleSignUpImages extends StatelessWidget {
  const googleSignUpImages({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
  final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: TColors.grey),
          ),
          child: IconButton(
            onPressed: () {
              if(kDebugMode){
                print("signInGoogle");
              }
              controller.signInWithGoogle();
            },
            icon: Image(
              height: TSizes.iconMd,
              width: TSizes.iconMd,
              image: AssetImage("assets/logos/google-icon.png"),
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: TColors.grey),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Image(
              height: TSizes.iconMd,
              width: TSizes.iconMd,
              image: AssetImage("assets/logos/facebook-icon.png"),
            ),
          ),
        ),
      ],
    );
  }
}

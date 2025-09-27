import 'dart:async';

import 'package:clone_shopping/common/widgets/successScreen/successScreen.dart';
import 'package:clone_shopping/features/authentication/screens/login/loginScreen.dart';
import 'package:clone_shopping/utils/constants/image_strings.dart';
import 'package:clone_shopping/utils/constants/text_strings.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimeForAutoREDirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      print("email verification called");
      final user = FirebaseAuth.instance.currentUser;
     await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      TLoaders.successSnackBar(title: "Email sent ",message: "Check your inbox and verify your email");
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh snap ",message: e.toString());
       print("${e} : ${e.toString()}");
    }
  }


  setTimeForAutoREDirect() {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();  // user data reload karo
      final user = FirebaseAuth.instance.currentUser;     // fir fresh user object lo
      if(user == null){
        timer.cancel();
        Get.offAll(() => const LoginScreen());
      }
      if (user!.emailVerified) {
        timer.cancel();
        Get.offAll(
              () => SuccessScreen(
            image: TImages.staticSuccessIllustration,
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
               Get.offAll(() => const LoginScreen()),
          ),
        );
      }
    });
  }

  checkEmailVerificationStatus(){

    final user = FirebaseAuth.instance.currentUser;
     if (user?.emailVerified ?? false) {

      Get.offAll(
            () => SuccessScreen(
          image: TImages.staticSuccessIllustration,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () =>
              AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }else{
       TLoaders.warningSnackBar(title: "oh snap ",message: "Please verify your email");
     }
  }
}

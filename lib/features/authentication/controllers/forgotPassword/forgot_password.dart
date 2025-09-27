import 'package:clone_shopping/utils/helpers/network_manager.dart';
import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
import '../../screens/passwordConfiguration/ResetPassword.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  passwordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        "Processing your request",
        "assets/images/animations/141594-animation-of-docer.json",
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!forgotPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.forgotPasswordEmail(
        email.text.trim(),
      );

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: "Email sent",
        message: "Email successfully sent to your email ",
      );
      
      Get.off(()=>ResetPassword(email:  email.text.trim(),));

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh Snap",message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
        "Processing your request",
        "assets/images/animations/141594-animation-of-docer.json",
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.forgotPasswordEmail(
        email,
      );

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: "Email sent",
        message: "Email successfully sent to your email ",
      );


    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh Snap",message: e.toString());
    }
  }
}

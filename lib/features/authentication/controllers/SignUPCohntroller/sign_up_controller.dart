import 'package:clone_shopping/features/authentication/screens/SignUpScreen/Verify_email.dart';
import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
import '../../../../data/repositries/userRepositries/user_Repositries.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/models/UserMode/user_model.dart';
class SignUPController extends GetxController {
  static SignUPController get instance => Get.find();

  /// variables
  ///
  final hidePassword = true.obs;
  final privacyPolicyBox = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  Future<void> signUp() async {

    try {
      ///Start Loading
      TFullScreenLoader.openLoadingDialog(
        "we are processing your information...",
        "assets/images/animations/72462-check-register.json",
      );

      ///Check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Validate form fields
      if (!signUpFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      ///privacy policy check
      if (!privacyPolicyBox.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(title: "Accept privacy policy",message: "Please accept the privacy policy to continue");
        return;
      }

      ///register with email and password
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );


      ///Save User
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);


      /// Success SnackBar
      // TLoaders.successSnackBar(title: "Congratulations",message: "You have successfully registered");

      Get.to(VerifyEmailScreen(email:  email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "oh snap!", message: e.toString());
    }
  }
}

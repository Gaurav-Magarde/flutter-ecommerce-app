  import 'package:clone_shopping/utils/helpers/network_manager.dart';
  import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
  import 'package:clone_shopping/utils/popups/loaders.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/foundation.dart';
  import 'package:get/get.dart';
  import 'package:get_storage/get_storage.dart';

  // IMPORTANT: Yahan apni Home Screen import karein
  // Neeche di gayi line ko apni actual home screen se badlein
  // Example: Apni Home Screen yahan import karein

  import '../../../data/repositries/dataRepositries/reposetry_authentication.dart';
  import '../../personalization/userRepository/user_controller.dart';

  class LoginController extends GetxController {

    final rememberMe = false.obs;
    final hidePassword = true.obs;
    final localStorage = GetStorage();
    final email = TextEditingController();
    final password = TextEditingController();
    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    @override
    void onInit() {
      email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
      password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
      super.onInit();
    }


    Future<void> signInWithEmailAndPassword() async {
      try {
        // Loader shuru karein
        TFullScreenLoader.openLoadingDialog(
          "Logging you in...",
          "assets/images/animations/141594-animation-of-docer.json"
        );

        // Internet connection check karein
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }

        // Form validation
        if (!loginFormKey.currentState!.validate()) {
          TFullScreenLoader.stopLoading();
          return;
        }

        // 'Remember Me' logic
        if (rememberMe.value) {
          localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
          localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
        }

        // Firebase se Sign In karein
       final credential =  await AuthenticationRepository.instance
            .signInWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Ensure controller exists and fetch fresh data
        AuthenticationRepository.instance.screenRedirect(currentUser: credential);



      } catch (e) {
        TFullScreenLoader.stopLoading();

          TLoaders.errorSnackBar(title: "Oh Snap!", message:  e.toString());

      }
    }

    Future<void> signInWithGoogle() async {
      try{
        // Loader start
        TFullScreenLoader.openLoadingDialog(
          "Logging you in...",
          "assets/images/animations/141594-animation-of-docer.json"
        );

        // Internet connection check
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          TFullScreenLoader.stopLoading();
          return;
        }


        final userCredential = await AuthenticationRepository.instance.signInWithGoogle();
        Get.put(UserController());

        // if not selected any gmail
        if(userCredential.user == null){
          TFullScreenLoader.stopLoading();
          TLoaders.warningSnackBar(title: "SignIn failed",message: "google sign in failed ! please try again");
          return;

        }
        await UserController.instance.saveUserRecord(userCredential);


        AuthenticationRepository.instance.screenRedirect();
      } catch (e) {
        TFullScreenLoader.stopLoading();

        TLoaders.errorSnackBar(title: "Oh Snap!", message:  e.toString());

      }
    }
  }
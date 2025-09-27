import 'dart:core';

import 'package:clone_shopping/features/personalization/Screens/Profile/ProfileScreen.dart';
import 'package:clone_shopping/features/personalization/userRepository/user_controller.dart';
import 'package:clone_shopping/utils/helpers/network_manager.dart';
import 'package:clone_shopping/utils/popups/full_screen_loader.dart';
import 'package:clone_shopping/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NameChangeController extends GetxController{
  static NameChangeController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final nameFormKey = GlobalKey<FormState>();

  Future<void> saveName() async {
    try{

      TFullScreenLoader.openLoadingDialog("Saving Your Name",
          "assets/images/animations/98783-packaging-in-progress.json");

    await Future.delayed(Duration(seconds: 3));

      if (!(nameFormKey.currentState!.validate())) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final connected = await NetworkManager.instance.isConnected();
      if (!connected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      await UserController.instance.updateOneField({
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim()
      });

      UserController.instance.user.value.firstName = firstName.text.trim();
      UserController.instance.user.value.lastName = lastName.text.trim();
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: "Name Changed",message: "Your name has been successfully changes");

      Get.off(()=>ProfileScreen());
    }catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error",message: e.toString());
    }
  }
}
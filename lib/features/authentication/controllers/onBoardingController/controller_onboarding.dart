import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/loginScreen.dart';

class onBoardingController extends GetxController{
  static onBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;


  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
      if(currentPageIndex.value==2){
        final deviceStorage = GetStorage();
        deviceStorage.write("IsFirstTime", false);
        Get.offAll(LoginScreen());
      }
      else{
        int index = currentPageIndex.value+1;
        pageController.jumpToPage(index);
      }
  }

  void skipPage(){
    final deviceStorage = GetStorage();
    deviceStorage.write("IsFirstTime", false);
    Get.offAll(LoginScreen());
  }
}
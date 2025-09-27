import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/ WishList/wishListScreen.dart';
import 'features/personalization/Screens/setting/SettingScreen.dart';
import 'features/shop/Strore/StoreScreen.dart';
import 'features/shop/home/HomeScreen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
  final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: (index) => {
            controller.selectedIndex.value = index
          },
          elevation: 0,
          height: 60,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: dark ? TColors.dark : Colors.white,
          indicatorColor: !dark ? TColors.dark.withAlpha(50) : Colors.white.withAlpha(20),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: ("Home")),
            NavigationDestination(icon: Icon(Iconsax.shop), label: ("store")),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: ("wishlist"),
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: ("profile")),
          ],
        ),
      ),
      body: Obx(
          () => controller.screens[controller.selectedIndex.value]

      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomeScreen(),
    StoreScreen(),
    WishListScreen(),
    SettingScreen(),
  ];
}

import 'package:clone_shopping/common/widgets/appbar/customAppBar.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/container/PrimaryHeaderContainer.dart';
import '../../../../common/widgets/list_tiles/UserProfileTile.dart';
import '../../../../data/repositries/dataRepositries/reposetry_authentication.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/Cart/cart_screen.dart';
import '../../../shop/Orders/Widgets/order_list_item.dart';
import '../Address/address_screen.dart';
import '../widgets/bank_accouont.dart';
import '../widgets/coupons_screen.dart';
import '../widgets/notification_screen.dart';
import 'LoadData/load_data_screen.dart';
import 'SettingMenuTile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainerWidget(
              height: 200,
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      "Account",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: Colors.white),
                    ),
                  ),

                  const UserProfileTile(),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            ///Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(

                children: [
                  SectionHeading(
                    title: "Account Setting",
                    textColor: dark ? Colors.white : TColors.darkGrey,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  SettingMenuTile(
                    title: "My Addresses",
                    subTitle: "Set shopping delivery address",
                    leadingIcon: Iconsax.safe_home,
                    onTap: ()=>Get.to(()=>const AddressScreen()),
                  ),
                  SettingMenuTile(
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    leadingIcon: Iconsax.shopping_cart,
                    onTap: ()=>Get.to(()=>const CartScreen()),
                  ),
                  SettingMenuTile(
                    title: "My Orders",
                    subTitle: "In-progress and Completed Orders",
                    leadingIcon: Iconsax.bag_tick,
                    onTap: ()=>Get.to(()=>const OrderListItem()),
                  ),
                  SettingMenuTile(
                    title: "Bank Account",
                    subTitle: "Withdraw balance to registered bank account",
                    leadingIcon: Iconsax.bank,
                    onTap: (){
                      Get.to(() => BankAccount());
                    }
                  ),
                  SettingMenuTile(
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupons",
                    leadingIcon: Iconsax.discount_shape,
                    onTap: (){
                      Get.to(()=>const CouponsScreen());
                    }
                  ),
                  SettingMenuTile(
                    title: "Notifications",
                    subTitle: "Set any kind of notification message",
                    leadingIcon: Iconsax.notification,
                    onTap: (){
                      Get.to(()=>const NotificationScreen());
                    }
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                  SectionHeading(
                    title: "App Setting",
                    textColor: dark ? Colors.white : TColors.darkGrey,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // SettingMenuTile(
                  //   title: "Load Data",
                  //   subTitle: "Upload Data to your cloud Firebase",
                  //   leadingIcon: Iconsax.document_upload,
                  //   onTap: (){
                  //     Get.to(()=>const LoadDataScreen());
                  //   },
                  // ),
                  SettingMenuTile(
                    title: "Geolocation",
                    subTitle: "Coming soon...",
                    leadingIcon: Iconsax.location,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  SettingMenuTile(
                    title: "Safe Mode",
                    subTitle: "Coming soon...",
                    leadingIcon: Iconsax.security_user,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  SettingMenuTile(
                    title: "HD Image Quality",
                    subTitle: "Coming soon...",
                    leadingIcon: Iconsax.image,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      AuthenticationRepository.instance.logOut();
                    }, child: Text("Logout")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

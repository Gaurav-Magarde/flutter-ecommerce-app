import 'package:clone_shopping/common/widgets/images/CirculaImage.dart';
import 'package:clone_shopping/common/widgets/texts/SectionHeading.dart';
import 'package:clone_shopping/features/personalization/Screens/Profile/Widgets/change_name.dart';
import 'package:clone_shopping/features/personalization/userRepository/user_controller.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/customAppBar.dart';
import 'Widgets/ProfiileMenu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            children: [
              ///profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () => controller.isUserLoading.value ?
          CircularImage(
          imageURL:  "assets/images/content/user.png",
            isNetworkImage
                : false,
            height: 80,
            width: 80,
          )
                          :CircularImage(
                        imageURL: controller.user.value.profilePicture == ""
                            ? "assets/images/content/user.png"
                            : controller.user.value.profilePicture,
                        isNetworkImage:
                            controller.user.value.profilePicture != ""
                            ? true
                            : false,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                            controller.uploadProfilePicture();
                      },
                      child: Text("change profile picture"),
                    ),
                  ],
                ),
              ),

              ///  Details
              // const SizedBox(height: TSizes.spaceBtwItems/2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              SectionHeading(
                title: "Profile Information",
                textColor: Colors.black,
              ),

              // const SizedBox(height: TSizes.spaceBtwItems,),
              Obx(
                () => ProfileMenu(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  icon: Iconsax.arrow_right_34,
                  onPressed: () => Get.off(ChangeName()),
                ),
              ),
              ProfileMenu(
                title: 'UserName',
                value: controller.user.value.username,
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              // const SizedBox(height: TSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              SectionHeading(
                title: "Personal Information",
                textColor: Colors.black,
              ),

              // const SizedBox(height: TSizes.spaceBtwItems,),
              ProfileMenu(
                title: 'User ID',
                value: '45689',
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.fullName == ""
                    ? "Add Mobile No"
                    : controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              ProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              ProfileMenu(
                title: 'Date of Birth',
                value: '10 Oct, 1994',
                onPressed: () {},
              ),
              const Divider(),

              // const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

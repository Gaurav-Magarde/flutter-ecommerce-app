import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/Screens/Profile/ProfileScreen.dart';
import '../../../features/personalization/userRepository/user_controller.dart';
import '../images/CirculaImage.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Column(
      children: [
        Obx(() {
          if(kDebugMode) print("user controller from the setting screen  : ${controller.user.value.email}");
          return Center();
    }),
        ListTile(
          leading: Obx(()
            =>  controller.user.value.profilePicture == '' ?
                Container(
                  height: 50,
                  width: 50,
                  decoration:BoxDecoration(),
                  child: Image.asset("assets/images/content/user.png"
                  ),
                )

                :CircularImage(
              imageURL: controller.user.value.profilePicture,
              height: 50,
              width: 50,
              padding: EdgeInsets.zero,
              borderRadius: 100,
              imageColor: null,
            ),
          ),
          title: Text(
            controller.user.value.fullName,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: Colors.white),
          ),
          subtitle: Text(
            controller.user.value.email,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () => Get.to(const ProfileScreen()),
            icon: Icon(Iconsax.edit),
          ),
        ),
      ],
    );
  }
}

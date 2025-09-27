  import 'package:clone_shopping/features/personalization/userRepository/user_controller.dart';
import 'package:clone_shopping/features/shop/Cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/appbar/customAppBar.dart';
import '../../../../../../common/widgets/products/cart/products/CartCounterWidget.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';

  class AppBarWidget extends StatelessWidget {
    const AppBarWidget({
      super.key,
    });

    @override
    Widget build(BuildContext context) {
      final controller  = UserController.instance;
      return TAppBar(
        title: Column(
          children: [
            Text(
              TTexts.homeAppbarTitle,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(color: TColors.grey),
            ),
            Obx(
             () => Text(
                ' ${controller.user.value.fullName}',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.apply(color: Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          CartCounterWidget(color: TColors.white,onPressed: (){
              Get.to(()=> CartScreen());
          },)
        ],
      );
    }
  }


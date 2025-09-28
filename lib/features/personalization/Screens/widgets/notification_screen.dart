import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();

        }, icon: Icon(Icons.arrow_back,color: TColors.white,)),

        backgroundColor: TColors.primary,
        title: Text("Notification",style: TextStyle(color: TColors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No new notifications",style: Theme.of(context).textTheme.titleMedium),
            // Text("Shop more for more coupons",style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.primary)),

          ],
        )),
      ),
    );
  }
}

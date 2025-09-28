import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/colors.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();

        }, icon: Icon(Icons.arrow_back,color: TColors.white,)),

        backgroundColor: TColors.primary,
        title: Text("MY Coupons",style: TextStyle(color: TColors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No coupons available",style: Theme.of(context).textTheme.bodyLarge),
            Text("Shop more for more coupons",style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.primary)),

          ],
        )),
      ),
    );
  }
}

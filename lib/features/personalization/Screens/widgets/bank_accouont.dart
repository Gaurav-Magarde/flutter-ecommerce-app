import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/colors.dart';

class BankAccount extends StatelessWidget {
  const BankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
            Get.back();

    }, icon: Icon(Icons.arrow_back,color: TColors.white,)),

        backgroundColor: TColors.primary,
        title: Text("Bank Account",style: TextStyle(color: TColors.white),),
      ),
      body: Center(child: Text("Coming Soon!",style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.primary),)),
    );
  }
}

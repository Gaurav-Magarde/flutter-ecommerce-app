import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../Controller/chckout_controller.dart';

class PaymentAmount extends StatelessWidget {
  const PaymentAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller  = Get.find<CheckoutController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("subtotal",style: Theme.of(context).textTheme.titleSmall,),
            Text("₹ ${controller.subTotal.value.toString()}",style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Discount",style: Theme.of(context).textTheme.titleSmall,),
            Text("₹ ${controller.discount.value.toString()}",style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("shipping fee",style: Theme.of(context).textTheme.titleSmall,),
            Text("₹ ${controller.shippingFee.value.toString()}",style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total",style: Theme.of(context).textTheme.titleSmall,),
            Text("₹ ${controller.total.value.toString()}",style: Theme.of(context).textTheme.titleLarge  )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2,),

      ],

    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class AddressChangeSnackBar extends StatelessWidget {
  const AddressChangeSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      backgroundColor: TColors.primary, content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Address Changed Successfully", style: Theme.of(context).textTheme.titleMedium,),
          SizedBox(height: TSizes.spaceBtwItems/2,),
          Row(children: [
            Text("Your address has been changed successfully.click cancel to change it", style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(width: TSizes.spaceBtwItems,),
            IconButton(onPressed: (){}, icon: Icon(Icons.cancel, color: TColors.primary,)),
          ],)
        ],
      ),

    ),


    );
  }
}

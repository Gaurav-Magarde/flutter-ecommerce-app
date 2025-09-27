import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';

class OrderStatusHelper{

  static Icon orderStatusIcon(OrderStatus status){
    if(status == OrderStatus.processing){
      return Icon(Icons.watch_later_outlined,color: Colors.grey,);
    }
    if(status == OrderStatus.shipped){
      return Icon(Iconsax.ship,color: Colors.blue,);
    }
    if(status == OrderStatus.delivered){
      return Icon(Iconsax.box_tick,color:TColors.primary,);
    }
    if(status == OrderStatus.cancelled){
      return Icon(Icons.cancel_outlined,color: Colors.orange,);
    }
    if(status == OrderStatus.returned){
      return Icon(Icons.cancel_outlined,color: Colors.red,);
    }

    return Icon(Icons.watch_later_outlined,color: Colors.grey,);
  }


  static Color orderStatusText(OrderStatus status){
    if(status == OrderStatus.processing){
      return Colors.grey;
    }
    if(status == OrderStatus.shipped){
      return Colors.blue;
    }
    if(status == OrderStatus.delivered){
      return TColors.primary;
    }
    if(status == OrderStatus.cancelled){
      return Colors.orange;
    }
    if(status == OrderStatus.returned) {
      return Colors.red;
    }
    return Colors.grey;
  }
}
import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon({
    super.key,
    required this.icon,
    this.radius = 50,
    this.color = TColors.grey, this.iconColor = TColors.black, this.height, this.width, this.size, this.onPressed,
  });

  final IconData icon;
  final double radius;
  final double ?size,height,width;
  final Color color,iconColor;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(TSizes.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: color,
          ),
          child: Icon(icon,color: iconColor,size: size,),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TCircularContainer extends StatelessWidget {
  const TCircularContainer({super.key, this.height = 400, this.width= 400,   this.radius  = 400, required this.backgroundColor, this.child, this.padding});

  final double height;
  final double width ;
  final EdgeInsetsGeometry?  padding;
  final double radius;
  final Color backgroundColor;
  final Widget ? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        // border: Border.all(color: TColors.darkGrey),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}

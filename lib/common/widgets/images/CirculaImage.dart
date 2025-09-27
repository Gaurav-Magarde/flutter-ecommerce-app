import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_shopping/utils/constants/sizes.dart';
import 'package:clone_shopping/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/colors.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width,
    this.height,
    required this.imageURL ,
    this.applyImageRadius = true,
    this.border,
    this.fit,
    this.padding = EdgeInsets.zero,
    this.isNetworkImage = true,
    this.borderRadius,
    this.imageColor, this.backGroundColor, this.onTap,
  });

  final double? width, height;

  final String imageURL;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backGroundColor;
  final Color ? imageColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry padding;
  final bool isNetworkImage;
  final double? borderRadius;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          color: backGroundColor ?? (THelperFunctions.isDarkMode(context) ?    TColors.black : TColors.white),
          borderRadius:applyImageRadius ? BorderRadius.circular(borderRadius ?? 10) :BorderRadius.zero,
        ),
        child: Padding(
          padding: padding ,
          child: Center(
            child: isNetworkImage ?
            CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: imageURL,
            ) :
            Image(
              image:
                  AssetImage(imageURL) as ImageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

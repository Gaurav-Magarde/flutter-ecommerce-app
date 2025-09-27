import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageURL,
    this.applyImageRadius = true,
    this.border,
    this.color = TColors.light,
    this.fit,
    this.padding = EdgeInsets.zero,
    this.isNetworkImage = true,
    this.onPressed,
    this.borderRadius = TSizes.md,
    this.circularIndicator = true ,
    this.isCached = true,
  });

  final double? width, height;
  final String imageURL;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color color;
  final BoxFit? fit;
  final EdgeInsetsGeometry padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;
  final bool circularIndicator ;
  final isCached ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: isNetworkImage
                ? !isCached ? Image.network(imageURL, fit: BoxFit.fill) : CachedNetworkImage(imageUrl: imageURL, fit: BoxFit.fill,
            placeholder: (context, url) => circularIndicator ? Center(child: CircularProgressIndicator()) : Container(height: double.infinity, width: double.infinity,decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(borderRadius),
            ),),
            )
                : Image(image: AssetImage(imageURL), fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

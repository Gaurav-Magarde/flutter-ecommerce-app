import 'package:clone_shopping/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class ShadowStyle{
  static final verticalShadowStyle  = BoxShadow(
color: TColors.darkGrey.withAlpha(25),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );
}
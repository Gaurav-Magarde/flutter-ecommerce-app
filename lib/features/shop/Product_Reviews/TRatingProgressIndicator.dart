
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({
    super.key, required this.value, required this.text,
  });

  final double value;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text)),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth( context ) * .5,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: TColors.grey,
              borderRadius: BorderRadius.circular(5),
              valueColor: AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        )
      ],
    );
  }
}

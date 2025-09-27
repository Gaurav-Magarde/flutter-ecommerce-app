import 'package:flutter/cupertino.dart';

import '../../../utils/constants/colors.dart';
import '../TCircularContainer/TCircularContainer.dart';

class HeaderContainerWidget extends StatelessWidget {
  const HeaderContainerWidget({
    super.key, required this.child, required this.height,
  });
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColors.primary,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: TColors.white.withAlpha(35),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundColor: TColors.white.withAlpha(35),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}

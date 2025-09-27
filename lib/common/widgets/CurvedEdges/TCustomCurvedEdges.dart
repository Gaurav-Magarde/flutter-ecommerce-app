import 'package:flutter/cupertino.dart';

class TCustomCurvedEdges extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve =  Offset(0,size.height-20);
    final lastCurve =  Offset(30,size.height-20);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondCurve =  Offset(0,size.height-20);
    final lastSecondCurve =  Offset(size.height-30,size.height-20);
    path.quadraticBezierTo(secondCurve.dx, secondCurve.dy, lastSecondCurve.dx, lastSecondCurve.dy);

    final thirdCurve =  Offset(size.width,size.height-20);
    final lastThirdCurve =  Offset(size.width,size.height);
    path.quadraticBezierTo(thirdCurve.dx, thirdCurve.dy, lastThirdCurve.dx, lastThirdCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
   return true;
  }

}
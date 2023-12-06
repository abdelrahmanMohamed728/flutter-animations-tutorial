import 'package:flutter/cupertino.dart';

class CircleClipeer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var radius = size.width / 2;
    final rect = Rect.fromCircle(
      center: Offset(
        radius,
        radius,
      ),
      radius: radius,
    );
    var path = Path();
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

import 'package:flutter/cupertino.dart';

import 'circle_side.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide circleSide;

  const HalfCircleClipper({
    required this.circleSide,
  });

  @override
  Path getClip(Size size) {
    return circleSide.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

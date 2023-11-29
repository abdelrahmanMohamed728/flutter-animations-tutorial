import 'package:flutter/material.dart';

enum CircleSide {
  left,
  right,
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        clockwise = false;
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        break;
      case CircleSide.right:
        clockwise = true;
        path.moveTo(0, 0);
        offset = Offset(0, size.height);
        break;
    }
    path.arcToPoint(
      offset,
      clockwise: clockwise,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
    );
    path.close();
    return path;
  }
}

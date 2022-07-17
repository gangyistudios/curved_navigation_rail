import 'dart:ui';

import 'package:flutter/material.dart';

class NavCustomPainter extends CustomPainter {
  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = false ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('painting');
    print(loc);
    print(size);
    print(size.width);
    print(size.height);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path1 = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.1) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.1) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    print((loc - 0.1) * size.height);

    //// SkETCHPAD STUFF
    ///
    // Move pointer to TOP RIGHT, X positive axis right , Y positive axis downwards
    var l0x = size.width;
    var l0y = 0.0;
    // Draw a line (length = 10% of the height) upwards, which will then begin the cubic curve
    var l1x = l0x;
    var l1y = (loc - 0.1) * size.height;
    // A point indented slightly inwards (to the left), and downwards
    var c1x1 = size.width - size.width * 0.05;
    var c1y1 = (loc + s * 0.20) * size.height;
    // A point at y=0 and x = width -
    var c1x2 = size.width - size.width * 0.6; //
    var c1y2 = loc * size.height; // y changes as loc traverses downwards
    // A point directly to the left of the first rail item
    var c1x3 = c1x2;
    var c1y3 = (loc + s * 0.5) * size.height;

    //
    var c2x1 = c1x2;
    var c2y1 = (loc + s) * size.height;
    //
    var c2x2 = c1x1;
    var c2y2 = (loc + s - s * 0.2) * size.height;
    //
    var c2x3 = size.width;
    var c2y3 = (loc + s + 0.1) * size.height;

    //
    var l2x = size.width;
    var l2y = size.height;

    var l3x = 0.0;
    var l3y = size.height;

    var l4x = 00.0;
    var l4y = 0.0;

    final path = Path()
      ..moveTo(l0x, l0y) // top left
      ..lineTo(l1x, l1y) // top left, then left a bit
      ..cubicTo(c1x1, c1y1, c1x2, c1y2, c1x3, c1y3)
      ..cubicTo(c2x1, c2y1, c2x2, c2y2, c2x3, c2y3)
      ..lineTo(l2x, l2y) // top right corner
      ..lineTo(l3x, l3y) // bottom right corner
      ..lineTo(l4x, l4y) // bottom left corner
      ..close();
    canvas.drawPath(path, paint);

    // var xpoints = [l0x, l1x, c1x1, c1x2, c1x3, c2x1, c2x2, c2x3, l2x, l3x, l4x];
    // var ypoints = [l0y, l1y, c1y1, c1y2, c1y3, c2y1, c2y2, c2y3, l2y, l3y, l4y];
    // // Draw points
    // var paint1 = Paint()
    //   ..color = Colors.brown
    //   ..strokeWidth = 20;
    // var points = <Offset>[];
    // for (int i = 0; i < xpoints.length; i++) {
    //   points.add(Offset(xpoints[i], ypoints[i]));
    // }
    // canvas.drawPoints(PointMode.points, points, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

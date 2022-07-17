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
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double w = size.width;
    final double h = size.height;

    List<Point> p = [
      Point(w, 0),
      Point(w, (loc - 0.1) * h),
      Point(w * 0.95, (loc + s * 0.20) * h),
      Point(w * 0.4, loc * h),
      Point(w * 0.4, (loc + s * 0.5) * h),
      Point(w * 0.4, (loc + s) * h),
      Point(w * 0.95, (loc + s - s * 0.2) * h),
      Point(w, (loc + s + 0.1) * h),
      Point(w, h),
      Point(0, h),
      Point(0, 0),
    ];

    final path = Path()
      ..moveTo(p[0].x, p[0].y)
      ..lineTo(p[1].x, p[1].y)
      ..cubicTo(p[2].x, p[2].y, p[3].x, p[3].y, p[4].x, p[4].y)
      ..cubicTo(p[5].x, p[5].y, p[6].x, p[6].y, p[7].x, p[7].y)
      ..lineTo(p[8].x, p[8].y)
      ..lineTo(p[9].x, p[9].y)
      ..lineTo(p[10].x, p[10].y)
      ..close();
    canvas.drawPath(path, paint);

    // visualisePoints(canvas, p);
  }

  void visualisePoints(Canvas canvas, List<Point> points) {
    var paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 20;
    canvas.drawPoints(
        PointMode.points, points.map((e) => Offset(e.x, e.y)).toList(), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class Point {
  final double x;
  final double y;

  Point(
    this.x,
    this.y,
  );

  @override
  String toString() {
    return ('($x, $y)');
  }
}

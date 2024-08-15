import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taegukgi/taegukgi/line_direction.dart';
import 'package:taegukgi/taegukgi/point_direction.dart';

class TaegukgiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final angle = atan(size.height / size.width);
    final unit = size.height / 2;

    _drawCircle(
      canvas: canvas,
      center: center,
      radius: unit / 2,
      angle: angle,
    );

    // 괘
    final length = unit / 2;
    final thickness = unit / 12;
    final spacing = unit / 24;
    final theta = pi / 2 - angle;
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = thickness;

    double calculateLeg(int index) =>
        unit * 3 / 4 + thickness / 2 + index * (spacing + thickness);

    // 건
    for (int index = 0; index < 3; index++) {
      final leg = calculateLeg(index);
      final gunCenter = Offset(
        center.dx - leg * cos(angle),
        center.dy - leg * sin(angle),
      );
      _drawLine(
        canvas,
        linePaint,
        lineCenter: gunCenter,
        lineLength: length,
        theta: theta,
        lineDirection: LineDirection.lbrt,
      );
    }

    // 곤
    for (int index = 0; index < 3; index++) {
      final leg = calculateLeg(index);
      final gonCenter = Offset(
        center.dx + leg * cos(angle),
        center.dy + leg * sin(angle),
      );
      _drawHalfLine(
        canvas,
        linePaint,
        lineCenter: gonCenter,
        lineLength: length,
        lineSpacing: spacing,
        theta: theta,
        lineDirection: LineDirection.lbrt,
      );
    }

    // 감
    for (int index = 0; index < 3; index++) {
      final leg = calculateLeg(index);
      final gamCenter = Offset(
        center.dx + leg * cos(angle),
        center.dy - leg * sin(angle),
      );

      if (index == 1) {
        _drawLine(
          canvas,
          linePaint,
          lineCenter: gamCenter,
          lineLength: length,
          theta: theta,
          lineDirection: LineDirection.ltrb,
        );
      } else {
        _drawHalfLine(
          canvas,
          linePaint,
          lineCenter: gamCenter,
          lineLength: length,
          lineSpacing: spacing,
          theta: theta,
          lineDirection: LineDirection.ltrb,
        );
      }
    }

    // 리
    for (int index = 0; index < 3; index++) {
      final leg = calculateLeg(index);
      final leeCenter = Offset(
        center.dx - leg * cos(angle),
        center.dy + leg * sin(angle),
      );

      if (index == 1) {
        _drawHalfLine(
          canvas,
          linePaint,
          lineCenter: leeCenter,
          lineLength: length,
          lineSpacing: spacing,
          theta: theta,
          lineDirection: LineDirection.ltrb,
        );
      } else {
        _drawLine(
          canvas,
          linePaint,
          lineCenter: leeCenter,
          lineLength: length,
          theta: theta,
          lineDirection: LineDirection.ltrb,
        );
      }
    }
  }

  void _drawCircle({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double angle,
  }) {
    final redPaint = Paint()..color = const Color(0xFFCE313C);
    final bluePaint = Paint()..color = const Color(0xFF134A9D);

    final circleRect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );
    canvas.drawArc(circleRect, pi + angle, pi, false, redPaint);
    canvas.drawArc(circleRect, angle, pi, false, bluePaint);

    final halfWidth = radius * cos(angle);
    final halfHeight = radius * sin(angle);

    final halfRedCenter = Offset(
      center.dx - halfWidth / 2,
      center.dy - halfHeight / 2,
    );
    final halfRedRect = Rect.fromCenter(
      center: halfRedCenter,
      width: radius,
      height: radius,
    );
    canvas.drawArc(halfRedRect, angle, pi, false, redPaint);

    final halfBlueCenter = Offset(
      center.dx + halfWidth / 2,
      center.dy + halfHeight / 2,
    );
    final halfBlueRect = Rect.fromCenter(
      center: halfBlueCenter,
      width: radius,
      height: radius,
    );
    canvas.drawArc(halfBlueRect, pi + angle, pi, false, bluePaint);
  }

  void _drawLine(
    Canvas canvas,
    Paint paint, {
    required Offset lineCenter,
    required double lineLength,
    required double theta,
    required LineDirection lineDirection,
  }) {
    final p1 = _calculatePoint(
      lineCenter: lineCenter,
      leg: lineLength,
      theta: theta,
      pointDirection: lineDirection == LineDirection.lbrt
          ? PointDirection.leftBottom
          : PointDirection.leftTop,
    );
    final p2 = _calculatePoint(
      lineCenter: lineCenter,
      leg: lineLength,
      theta: theta,
      pointDirection: lineDirection == LineDirection.lbrt
          ? PointDirection.rightTop
          : PointDirection.rightBottom,
    );
    canvas.drawLine(p1, p2, paint);
  }

  void _drawHalfLine(
    Canvas canvas,
    Paint paint, {
    required Offset lineCenter,
    required double lineLength,
    required double lineSpacing,
    required double theta,
    required LineDirection lineDirection,
  }) {
    final p1 = _calculatePoint(
      lineCenter: lineCenter,
      leg: lineLength,
      theta: theta,
      pointDirection: lineDirection == LineDirection.lbrt
          ? PointDirection.leftBottom
          : PointDirection.leftTop,
    );
    final p2 = _calculatePoint(
      lineCenter: lineCenter,
      leg: lineSpacing,
      theta: theta,
      pointDirection: lineDirection == LineDirection.lbrt
          ? PointDirection.leftBottom
          : PointDirection.leftTop,
    );
    canvas.drawLine(p1, p2, paint);

    final p3 = _calculatePoint(
      lineCenter: lineCenter,
      leg: lineSpacing,
      theta: theta,
      pointDirection: lineDirection == LineDirection.lbrt
          ? PointDirection.rightTop
          : PointDirection.rightBottom,
    );
    final p4 = _calculatePoint(
      lineCenter: lineCenter,
      leg: lineLength,
      theta: theta,
      pointDirection: lineDirection == LineDirection.lbrt
          ? PointDirection.rightTop
          : PointDirection.rightBottom,
    );
    canvas.drawLine(p3, p4, paint);
  }

  Offset _calculatePoint({
    required Offset lineCenter,
    required double leg,
    required double theta,
    required PointDirection pointDirection,
  }) {
    final dx = leg / 2 * cos(theta);
    final dy = leg / 2 * sin(theta);

    switch (pointDirection) {
      case PointDirection.leftTop:
        return Offset(
          lineCenter.dx - dx,
          lineCenter.dy - dy,
        );

      case PointDirection.leftBottom:
        return Offset(
          lineCenter.dx - dx,
          lineCenter.dy + dy,
        );

      case PointDirection.rightTop:
        return Offset(
          lineCenter.dx + dx,
          lineCenter.dy - dy,
        );

      case PointDirection.rightBottom:
        return Offset(
          lineCenter.dx + dx,
          lineCenter.dy + dy,
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class TimerPainter extends CustomPainter {
  final double progress;

  TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint baseCircle = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint progressCircle = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 77, 187, 159),
          Color.fromARGB(255, 34, 179, 164)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ))
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;

    // Draw base circle
    canvas.drawCircle(Offset(radius, radius), radius, baseCircle);

    // Draw progress arc
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2, // Start angle
      sweepAngle, // Sweep angle
      false,
      progressCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';

class WaveStripPainter extends CustomPainter {
  final Color greenLighter;
  final Color greenLight;

  WaveStripPainter({required this.greenLighter, required this.greenLight});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [greenLighter, greenLight],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    double stripWidth = size.width /
        54; // Reduced the width of each strip to be very small (65 strips)
    double padding = 2.0; // Padding between strips
    List<double> waveHeights = [
      200,
      194,
      188,
      182,
      176,
      170,
      164,
      158,
      155,
      155,
      158,
      161,
      164,
      167,
      170,
      173,
      176,
      177.1666667,
      176.5,
      174,
      171.5,
      169,
      166.5,
      164,
      161.5,
      159,
      159.3333333,
      162.5,
      168.5,
      174.5,
      180.5,
      186.5,
      192.5,
      198.5,
      204.5,
      206.8333333,
      205.5,
      200.5,
      195.5,
      190.5,
      185.5,
      180.5,
      175.5,
      170.5,
      168.6666667,
      170,
      174.5,
      179,
      183.5,
      188,
      192.5,
      197,
      201.5,
      206
    ];

    for (int i = 0; i < 54; i++) {
      double waveHeight = waveHeights[i % waveHeights.length];
      Path path = Path()
        ..moveTo(i * stripWidth + padding / 2, 0)
        ..lineTo((i + 1) * stripWidth - padding / 2, 0)
        ..lineTo((i + 1) * stripWidth - padding / 2, waveHeight)
        ..lineTo(i * stripWidth + padding / 2, waveHeight)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

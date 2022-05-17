import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class JointerPainter extends CustomPainter {
  final Color? shadowColor, gradColor1, gradColor2;

  JointerPainter(
      {@required this.shadowColor,
      @required this.gradColor1,
      @required this.gradColor2});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(28.264, 40.829);
    path_0.lineTo(73.218, 67.912);
    path_0.lineTo(51.27, 80.992);
    path_0.lineTo(6.316, 53.908);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff5a4a33).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(72.5, 5);
    path_1.lineTo(100.324, 21.885);
    path_1.lineTo(29.823999999999998, 64.667);
    path_1.lineTo(8.5, 50);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff5a4a33).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(6.5, 54);
    path_2.lineTo(14, 52.5);
    path_2.lineTo(20, 44.5);
    path_2.lineTo(6.5, 41);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff5a4a33).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);
    Path path_4 = Path();
    path_4.moveTo(49.533, 42);
    path_4.lineTo(77.93299999999999, 58.4);
    path_4.lineTo(53.965, 72.236);
    path_4.lineTo(25.565000000000005, 55.836000000000006);
    path_4.close();
    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xffffd4ac).withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_3 = Path();
    path_3.moveTo(72.847, 0);
    path_3.lineTo(100.10499999999999, 15.737);
    path_3.lineTo(28.191, 57.257);
    path_3.lineTo(10.459, 47.02);
    path_3.cubicTo(5.1979999999999995, 43.982000000000006, 5.1979999999999995,
        39.057, 10.459, 36.02);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.01312000, size.height * -0.4070000),
        Offset(size.width * 0.4020000, size.height * 0.5200000),
        [Color(0xffee502e).withOpacity(1), Color(0xffffd4ac).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

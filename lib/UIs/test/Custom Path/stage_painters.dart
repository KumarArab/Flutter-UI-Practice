import 'package:flutter/material.dart';

class BigStagePainter extends CustomPainter {
  final Color? shadowColor, stageColor;

  BigStagePainter({this.shadowColor, this.stageColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = shadowColor!.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                0, 0, size.width * 0.5742787, size.height * 0.8720528),
            bottomRight: Radius.circular(size.width * 0.1093866),
            bottomLeft: Radius.circular(size.width * 0.1093866),
            topLeft: Radius.circular(size.width * 0.1093866),
            topRight: Radius.circular(size.width * 0.1093866)),
        paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = stageColor!.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                0, 0, size.width * 0.5742787, size.height * 0.8720528),
            bottomRight: Radius.circular(size.width * 0.1093866),
            bottomLeft: Radius.circular(size.width * 0.1093866),
            topLeft: Radius.circular(size.width * 0.1093866),
            topRight: Radius.circular(size.width * 0.1093866)),
        paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

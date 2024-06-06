import 'dart:ui';

import 'package:flutter/material.dart';

class WaveSlider extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  const WaveSlider({super.key, this.height = 50, this.width = 350, required this.color});

  @override
  State<WaveSlider> createState() => _WaveSliderState();
}

class _WaveSliderState extends State<WaveSlider> {
  double _dragPos = 0;
  double _dragPosPercentage = 0;

  void updateDragPos(double val) {
    double newDragPos = 0;

    if (val <= 0) {
      newDragPos = 0;
    } else if (val > 0 && val <= widget.width) {
      newDragPos = val;
    } else {
      newDragPos = widget.width;
    }

    _dragPos = newDragPos;
    _dragPosPercentage = _dragPos / widget.width;
    setState(() {});
  }

  void onDragStart(DragStartDetails details, BuildContext context) {
    RenderBox box = context.findRenderObject()! as RenderBox;
    final offset = box.globalToLocal(details.globalPosition);
    updateDragPos(offset.dx);
  }

  void onDragUpdate(DragUpdateDetails details, BuildContext context) {
    RenderBox box = context.findRenderObject()! as RenderBox;
    final offset = box.globalToLocal(details.globalPosition);
    updateDragPos(offset.dx);
  }

  void onDragEnd(DragEndDetails details, BuildContext context) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) => onDragStart(details, context),
      onHorizontalDragUpdate: (details) => onDragUpdate(details, context),
      onHorizontalDragEnd: (details) => onDragEnd(details, context),
      child: Container(
          // decoration: const BoxDecoration(color: Colors.red),
          height: widget.height,
          width: widget.width,
          child: CustomPaint(
            painter: WavePainter(color: widget.color, dragPosPercentage: _dragPosPercentage, sliderPos: _dragPos),
            size: const Size(350, 50),
          )),
    );
  }
}

class WavePainter extends CustomPainter {
  final double dragPosPercentage;
  final double sliderPos;
  final Color color;
  double previousSliderPos = 0;
  WavePainter({super.repaint, required this.dragPosPercentage, required this.sliderPos, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    _paintAnchors(canvas, size);
    _paintWaveLine(canvas, size);
    // _paintLine(canvas, size);
    // _paintBlock(canvas, size);
  }

  void _paintAnchors(Canvas canvas, Size size) {
    Paint anchorPainter = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0.0, size.height), 5, anchorPainter);
    canvas.drawCircle(Offset(size.width, size.height), 5, anchorPainter);
  }

  void _paintWaveLine(Canvas canvas, Size size) {
    Paint wavePathPainter = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double waveWidth = 80;
    double waveHeight = 50;
    double waveStart = sliderPos - waveWidth / 2;
    double waveEnd = sliderPos + waveWidth / 2;
    double bezierwidth = waveWidth / 2;

    double bezierAX1 = waveStart + bezierwidth * 0.5;
    double bezierAY1 = size.height;
    double bezierAX2 = waveStart + bezierwidth * 0.5;
    double bezierAY2 = size.height - waveHeight;
    double bezierAX3 = sliderPos;
    double bezierAY3 = size.height - waveHeight;

    double bezierBX1 = sliderPos + bezierwidth * 0.5;
    double bezierBY1 = size.height - waveHeight;
    double bezierBX2 = sliderPos + bezierwidth * 0.5;
    double bezierBY2 = size.height;
    double bezierBX3 = waveEnd;
    double bezierBY3 = size.height;

    double bendability = 25;
    double maxBendDiff = 20;

    double bendDiff = (sliderPos - previousSliderPos).abs();
    if (bendDiff > maxBendDiff) {
      bendDiff = maxBendDiff;
    }
    double bend = lerpDouble(0.0, bendability, bendDiff / maxBendDiff) ?? 0;

    bool isSlideLeft = sliderPos < previousSliderPos;

    if (isSlideLeft) {
      bezierAX1 -= bend;
      bezierAX2 += bend;
      bezierBX1 += bend;
      bezierBX2 -= bend;
    } else {
      bezierAX1 += bend;
      bezierAX2 -= bend;
      bezierBX1 -= bend;
      bezierBX2 += bend;
    }

    Path path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(waveStart, size.height);
    path.cubicTo(bezierAX1, bezierAY1, bezierAX2, bezierAY2, bezierAX3, bezierAY3);
    path.cubicTo(bezierBX1, bezierBY1, bezierBX2, bezierBY2, bezierBX3, bezierBY3);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, wavePathPainter);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    previousSliderPos = oldDelegate.sliderPos;
    return oldDelegate.sliderPos != this.sliderPos;
  }
}

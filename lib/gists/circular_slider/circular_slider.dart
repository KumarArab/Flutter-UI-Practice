import 'dart:math';

import 'package:flutter/material.dart';

class MyCircularSlider extends StatefulWidget {
  const MyCircularSlider({Key? key}) : super(key: key);

  @override
  State<MyCircularSlider> createState() => _MyCircularSliderState();
}

class _MyCircularSliderState extends State<MyCircularSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circular Slider"),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            child: CustomPaint(
              size: const Size(150, 150),
              painter: CircularSliderPainter(),
            ),
          ),
          Knob()
        ],
      ),
    );
  }
}

class CircularSliderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    Rect rect = Rect.fromCircle(center: center, radius: size.width);

    final rainbowPaint = Paint()
      ..shader = const SweepGradient(
              colors: [Colors.purple, Colors.blue, Colors.green, Colors.yellow, Colors.orange, Colors.red])
          .createShader(rect)..style = PaintingStyle.stroke..strokeWidth = 40
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 0, pi * 2, false, Paint()..style = PaintingStyle.stroke..strokeWidth = 50);
     canvas.drawArc(
        rect,
        0,
        pi ,
        false,
       rainbowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class Knob extends StatelessWidget {
  const Knob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,width: 40,decoration:  BoxDecoration(color: Colors.white,
      border: Border.all(color: Colors.black,width: 5),
      shape: BoxShape.circle),
    );
  }
}
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class FlutterPaint extends StatefulWidget {
  FlutterPaint({Key? key}) : super(key: key);

  @override
  State<FlutterPaint> createState() => _FlutterPaintState();
}

class _FlutterPaintState extends State<FlutterPaint> {
  final _offsets = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _offsets.add(details.globalPosition);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _offsets.add(details.globalPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _offsets.add(Offset.zero);
          });
        },
        child: Center(
          child: CustomPaint(
            willChange: true,
            foregroundPainter: FlutterPainter(offsets: _offsets),
            child: Container(
              color: Colors.amberAccent,
              width: SizeConfig.width!,
              height: SizeConfig.height!,
            ),
          ),
        ),
      ),
    );
  }
}

class FlutterPainter extends CustomPainter {
  final List<Offset> offsets;

  FlutterPainter({required this.offsets});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..isAntiAlias = true
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < offsets.length - 1; i++) {
      if (offsets[i] != Offset.zero && offsets[i + 1] != Offset.zero) {
        canvas.drawLine(offsets[i], offsets[i + 1], paint);
      } else if (offsets[i] != Offset.zero && offsets[i + 1] == Offset.zero) {
        canvas.drawPoints(PointMode.polygon, [offsets[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

import 'dart:math';

import 'package:flutter/material.dart';

class CompassViewPainter extends CustomPainter {
  final Color? color;
  final int majorTickerCounter;
  final int minorTickerCounter;
  final CardinalityMap cardinalityMap;

  CompassViewPainter(
      {this.color,
      this.majorTickerCounter = 36,
      this.minorTickerCounter = 180,
      this.cardinalityMap = const {0: 'N', 90: 'E', 180: 'S', 270: 'W'}});

  late final majorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color!
    ..strokeWidth = 2.0;

  late final minorScalePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color!.withOpacity(0.5)
    ..strokeWidth = 1.0;

  late final majorTextStyle = TextStyle(color: color!, fontSize: 12);
  late final cardinalityStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);

  late final _majorTicks = _layoutScale(majorTickerCounter);
  late final _minorTicks = _layoutScale(minorTickerCounter);
  late final _angleTicks = _layoutScale(majorTickerCounter ~/ 2);
  late final _angleDegree = _layoutAngleScale(_angleTicks);

  @override
  void paint(Canvas canvas, Size size) {
    const origin = Offset.zero;
    final center = size.center(origin);
    final radius = size.width / 2;

    final majorTickLength = size.width * 0.08;
    final minorTickLength = size.width * 0.055;
    // canvas.save();

    for (final angle in _majorTicks) {
      final tickerStart =
          Offset.fromDirection(_correctAngle(angle).toRadians(), radius);
      final tickerEnd = Offset.fromDirection(
          _correctAngle(angle).toRadians(), radius - majorTickLength);
      canvas.drawLine(
          center + tickerStart, center + tickerEnd, majorScalePaint);
    }

//paint minor ticks
    for (final angle in _minorTicks) {
      final tickerStart =
          Offset.fromDirection(_correctAngle(angle).toRadians(), radius);
      final tickerEnd = Offset.fromDirection(
          _correctAngle(angle).toRadians(), radius - minorTickLength);
      canvas.drawLine(
          center + tickerStart, center + tickerEnd, minorScalePaint);
    }
//paint angle degree
    for (final angle in _angleDegree) {
      final textPadding = majorTickLength - size.width * 0.002;

      final textPainter = TextSpan(
        text: angle.toStringAsFixed(0),
        style: majorTextStyle,
      ).toPainter()
        ..layout();

      final layoutOffset = Offset.fromDirection(
          (_correctAngle(angle) / 1.8).toRadians(), radius - textPadding);
      final offset = center + layoutOffset;
      canvas.restore();
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate((angle / 1.8).toRadians());
      canvas.translate(-offset.dx, -offset.dy);
      textPainter.paint(
        canvas,
        Offset(offset.dx - (textPainter.width / 2) - (angle / 1.8).toRadians(),
            offset.dy),
      );
    }

    //paint cardinality text
    for (final cardinality in cardinalityMap.entries) {
      final textPadding = majorTickLength + size.width * 0.06;
      final angle = cardinality.key.toDouble();
      final text = cardinality.value;

      final textPainter = TextSpan(
              text: text,
              style: cardinalityStyle.copyWith(
                  color: text == 'N' ? Colors.red : null))
          .toPainter()
        ..layout();
      final layoutOffset = Offset.fromDirection(
          (_correctAngle(angle) / 1.8).toRadians(), radius - textPadding);
      final offset = center + layoutOffset;
      canvas.restore();
      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate((angle / 1.8).toRadians());
      canvas.translate(-offset.dx, -offset.dy);
      textPainter.paint(
        canvas,
        Offset(offset.dx - (textPainter.width / 2) - (angle / 1.8).toRadians(),
            offset.dy),
      );
    }

    // canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  List<double> _layoutScale(int ticks) {
    final scale = 360 / ticks;
    return List.generate(ticks, (index) => index * scale);
  }

  List<double> _layoutAngleScale(List<double> ticks) {
    List<double> angle = [];

    for (var i = 0; i < ticks.length; i++) {
      if (i == ticks.length - 1) {
        double degreeVal = (ticks[i] + 360) / 2;
        angle.add(degreeVal);
      } else {
        double degreeVal = (ticks[i] + ticks[i + 1]) / 2;
        angle.add(degreeVal);
      }
    }
    debugPrint(ticks.toString());
    debugPrint(angle.toString());
    return angle;
  }

  double _correctAngle(double angle) => angle - 90;
}

typedef CardinalityMap = Map<num, String>;

extension on num {
  double toRadians() => this * pi / 100;
}

extension on TextSpan {
  TextPainter toPainter({TextDirection textDirection = TextDirection.ltr}) =>
      TextPainter(text: this, textDirection: textDirection);
}

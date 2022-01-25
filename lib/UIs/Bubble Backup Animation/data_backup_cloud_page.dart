import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/bubble_backup_animation.dart';
import 'package:testapp/utils/size_config.dart';
import 'dart:math' as math;

class _Bubble {
  final Color? color;
  final double? direction;
  final double? speed;
  final double? size;
  final double? initialPosition;

  _Bubble({
    this.color,
    this.direction,
    this.speed,
    this.size,
    this.initialPosition,
  });
}

class DataBackupCloudPage extends StatelessWidget {
  DataBackupCloudPage(
      {Key? key,
      this.progressAnimation,
      this.cloudOutAnimation,
      this.bubbleAnimation})
      : super(key: key);

  final Animation<double>? progressAnimation,
      cloudOutAnimation,
      bubbleAnimation;

  final bubbles = List<_Bubble>.generate(500, (index) {
    final size = math.Random().nextInt(20) + 5.0;
    final speed = math.Random().nextInt(50) + 1.0;
    final directionRandom = math.Random().nextBool();
    final colorRandom = math.Random().nextBool();
    final direction =
        math.Random().nextInt(250) * (directionRandom ? 1.0 : -1.0);
    final color = colorRandom ? mainDataBackupColor : secondaryDataBackkupColor;

    return _Bubble(
        color: color,
        direction: direction,
        speed: speed,
        size: size,
        initialPosition: index * 10.0);
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([progressAnimation, cloudOutAnimation]),
        builder: (context, snapshot) {
          final size = SizeConfig.width! * 0.5;
          final circleSize = size *
              math.pow(
                  (progressAnimation!.value + cloudOutAnimation!.value + 1),
                  2.5);
          final topPosition = SizeConfig.height! * 0.45;
          final centerMargin = SizeConfig.width! - circleSize;
          final leftSize =
              size * 0.6 * math.pow((1 - progressAnimation!.value), 8);
          final rightSize =
              size * 0.7 * math.pow((1 - progressAnimation!.value), 8);
          final leftMargin = SizeConfig.width! / 2 - leftSize * 1.32;
          final rightMargin = SizeConfig.width! / 2 - rightSize * 1.2;
          final middleMargin = SizeConfig.width! / 2 -
              (size / 2) * math.pow((1 - progressAnimation!.value), 8);
          final topOutPosition = SizeConfig.height! * cloudOutAnimation!.value;
          return Positioned(
            left: 0,
            right: 0,
            top: topPosition - circleSize + topOutPosition,
            height: circleSize,
            child: Stack(
              children: [
                Positioned(
                  height: leftSize / 2,
                  width: size * math.pow((1 - progressAnimation!.value), 8),
                  left: middleMargin,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  height: leftSize,
                  width: leftSize,
                  left: leftMargin,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  height: rightSize,
                  width: rightSize,
                  right: rightMargin,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  height: circleSize,
                  width: circleSize,
                  bottom: 0,
                  left: centerMargin / 2,
                  child: ClipOval(
                    child: CustomPaint(
                      foregroundPainter:
                          _CloudBubblePainter(bubbleAnimation, bubbles),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class _CloudBubblePainter extends CustomPainter {
  _CloudBubblePainter(this.animation, this.bubbles) : super(repaint: animation);

  final Animation<double>? animation;
  final List<_Bubble>? bubbles;
  @override
  void paint(Canvas canvas, Size size) {
    for (_Bubble _bubble in bubbles!) {
      final offset = Offset(
          size.width / 2 + _bubble.direction! * animation!.value,
          size.height * 1.2 * (1 - animation!.value) -
              _bubble.speed! * animation!.value +
              _bubble.initialPosition! * (1 - animation!.value));
      canvas.drawCircle(offset, _bubble.size!, Paint()..color = _bubble.color!);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

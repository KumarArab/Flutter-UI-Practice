import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/bubble_backup_animation.dart';
import 'package:vector_math/vector_math.dart' as vector;

class DataBackupCompletedPage extends AnimatedWidget {
  DataBackupCompletedPage({this.endingAnimation})
      : super(listenable: endingAnimation!);

  final Animation<double>? endingAnimation;

  Animation get value => (listenable as Animation);
  @override
  Widget build(BuildContext context) {
    return endingAnimation!.value > 0
        ? Positioned.fill(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomPaint(
                        foregroundPainter: _DataBackupCompletedPainter(
                            animation: endingAnimation),
                        child: const SizedBox(
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Expanded(
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 400),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (_, double value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                              offset: Offset(0.0, 50 * (1 - value)),
                              child: child),
                        );
                      },
                      child: Column(
                        children: [
                          const Text(
                            "data has successfully\nuploaded",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          const Spacer(),
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              child: Text(
                                "OK",
                                style: TextStyle(color: mainDataBackupColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _DataBackupCompletedPainter extends CustomPainter {
  _DataBackupCompletedPainter({this.animation}) : super(repaint: animation);

  Animation<double>? animation;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = mainDataBackupColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final circlePath = Path();
    circlePath.addArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width,
            height: size.height),
        vector.radians(-90.0),
        vector.radians(360.0 * animation!.value));

    final leftLine = size.width * 0.2;
    final rightLine = size.width * 0.32;

    final leftPercent = animation!.value > 0.5 ? 1.0 : animation!.value / 0.5;

    final rightPercent =
        animation!.value < 0.5 ? 0.0 : (animation!.value - 0.5) / 0.5;
    canvas.save();

    canvas.translate(size.width / 3, size.height / 2);

    canvas.rotate(vector.radians(-45));
    canvas.drawLine(Offset.zero, Offset(0.0, leftLine * leftPercent), paint);

    canvas.drawLine(Offset(0.0, leftLine),
        Offset(rightLine * rightPercent, leftLine), paint);

    canvas.restore();

    canvas.drawPath(circlePath, paint);

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

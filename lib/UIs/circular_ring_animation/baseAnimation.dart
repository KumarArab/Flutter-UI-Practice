import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class BaseAnimation extends StatefulWidget {
  const BaseAnimation();
  @override
  State<BaseAnimation> createState() => _BaseAnimationState();
}

class _BaseAnimationState extends State<BaseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation? _animation1, _animation2, _animation3;
  double? sw = SizeConfig.width;
  double? sh = SizeConfig.height;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // END: 430

    _animation1 = Tween(begin: 0.0, end: sw! * 1.195).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Cubic(.20, .20, 1, 0),
      ),
    );
    _animation2 = Tween(begin: 0.0, end: sw! * 1.195).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Cubic(.10, .4, .50, 0),
      ),
    );

    _animation3 = Tween(begin: 0.0, end: sw! * 1.195).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Cubic(0.20, .65, .30, 0),
      ),
    );
    initDelay();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void initDelay() async {
    await Future.delayed(const Duration(milliseconds: 200), () {});
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          children: [
            Visibility(
              visible: _animationController.value != 1,
              child: CustomPaint(
                painter: AnimationPainter(
                  transparentCircleRadius: _animation1!.value,
                  outerCircleRadius: _animation2!.value,
                  outerThinCircleRadius: _animation3!.value,
                ),
                size: Size(sw!, sh!),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnimationPainter extends CustomPainter {
  final double transparentCircleRadius,
      outerThinCircleRadius,
      outerCircleRadius;

  AnimationPainter({
    required this.transparentCircleRadius,
    required this.outerThinCircleRadius,
    required this.outerCircleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final paint = Paint();
    path.fillType = PathFillType.evenOdd;
    paint.color = const Color(0xff1B262B);

    path.addRect(Rect.largest);
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        // radius: radius,
        radius: transparentCircleRadius,
      ),
    );
    canvas.drawPath(path, paint);

    final circlePaint = Paint()
      ..color = const Color(0xff067770)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      outerCircleRadius,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      outerThinCircleRadius,
      circlePaint
        ..strokeWidth = 10
        ..color = const Color(0xff067770).withOpacity(0.6),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

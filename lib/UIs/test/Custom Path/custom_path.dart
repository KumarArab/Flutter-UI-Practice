import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class CustomPath extends StatefulWidget {
  const CustomPath({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CustomPathState();
  }
}

class CustomPathState extends State<CustomPath>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  Path? _path;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller!.forward();
    _path = drawPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: CustomPaint(
              painter: PathPainter(_path!),
            ),
          ),
          Positioned(
            top: calculate(_animation!.value).dy,
            left: calculate(_animation!.value).dx,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              width: 10,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Path drawPath() {
    double? screenWidth = SizeConfig.width;
    double? screenHeight = SizeConfig.height;
    Size size = Size(screenWidth!, screenHeight!);
    Path path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.9);
    path.quadraticBezierTo(size.width * 1.5, size.height * 0.8,
        size.width * 0.2, size.height * 0.7);
    path.quadraticBezierTo(
        -1.5, size.height * 0.6, size.width * 0.8, size.height * 0.6);
    path.quadraticBezierTo(size.width * 1.5, size.height * 0.4,
        size.width * 0.2, size.height * 0.5);
    path.quadraticBezierTo(
        -1.5, size.height * 0.2, size.width * 0.8, size.height * 0.4);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path!.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }
}

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

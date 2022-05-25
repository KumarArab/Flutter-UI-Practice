import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArcWidget extends StatefulWidget {
  const ArcWidget({Key? key}) : super(key: key);

  @override
  _ArcWidgetState createState() => _ArcWidgetState();
}

class _ArcWidgetState extends State<ArcWidget> {
  final double width = 200;
  final double height = 200;
  double baseAngle = 0;
  Offset? lastPosition;
  double lastBaseAngle = 0;
  int tab = 0;
  // Path? _path;

  // @override
  // void initState() {
  //   _path = _drawPath();
  //   super.initState();
  // }

  // Path _drawPath() {
  //   double size.width = MediaQuery.of(context).size.width / 3;
  //   double size.height = 50;
  //   Path path = Path()
  //     ..moveTo(0, size.height)
  //     ..quadraticBezierTo(size.width * 0.2, size.height, size.width * 0.1,
  //         size.height * 0.5)
  //     ..quadraticBezierTo(0, 0, size.width * 0.3, 0)
  //     ..close();

  //   return path;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: width,
              height: height,
              child: CustomPaint(
                painter: ArcPainter(100, baseAngle),
                child: GestureDetector(
                  onVerticalDragStart: (value) {
                    setInitialState(value);
                  },
                  onHorizontalDragUpdate: (value) {
                    updateAngle(value);
                  },
                  onVerticalDragUpdate: (value) {
                    updateAngle(value);
                  },
                  onHorizontalDragStart: (value) {
                    setInitialState(value);
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.amber,
              child: Stack(children: [
                AnimatedPositioned(
                  curve: Curves.bounceOut,
                  duration: const Duration(milliseconds: 300),
                  top: 10,
                  left: (MediaQuery.of(context).size.width / 3) * tab,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width / 3, 50),
                      painter: TabPainter(),
                    ),
                  ),
                ),
                Positioned(
                  top: 59,
                  child: Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white),
                ),
                Positioned(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.abc),
                            onPressed: () {
                              setState(() {
                                tab = 0;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.add_box),
                            onPressed: () {
                              setState(() {
                                tab = 1;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.air),
                            onPressed: () {
                              setState(() {
                                tab = 2;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  void updateAngle(DragUpdateDetails value) {
    double result = math.atan2(value.localPosition.dy - height / 2,
            value.localPosition.dx - width / 2) -
        math.atan2(lastPosition!.dy - height / 2, lastPosition!.dx - width / 2);
    setState(() {
      baseAngle = lastBaseAngle + result;
    });
  }

  void setInitialState(DragStartDetails value) {
    lastPosition = value.localPosition;
    lastBaseAngle = baseAngle;
  }
}

class TabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
          size.width * 0.2, size.height, size.width * 0.15, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.1, 0, size.width * 0.3, 0)
      ..lineTo(size.width * 0.7, 0)
      ..quadraticBezierTo(
          size.width * 0.9, 0, size.width * 0.85, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.8, size.height, size.width * 1.1, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ArcPainter extends CustomPainter {
  final double radius;
  double baseAngle;
  final Paint red = createPaintForColor(Colors.red);
  final Paint blue = createPaintForColor(Colors.blue);
  final Paint green = createPaintForColor(Colors.green);

  ArcPainter(this.radius, this.baseAngle);
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    canvas.drawArc(rect, baseAngle, sweepAngle(), false, blue);
    canvas.drawArc(rect, baseAngle + 2 / 3 * math.pi, sweepAngle(), false, red);
    canvas.drawArc(
        rect, baseAngle + 4 / 3 * math.pi, sweepAngle(), false, green);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double sweepAngle() => 0.8 * 2 / 3 * math.pi;
}

Paint createPaintForColor(Color color) {
  return Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 15;
}

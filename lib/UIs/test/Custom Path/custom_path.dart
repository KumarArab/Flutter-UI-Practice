import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return JourneyScreenState();
  }
}

class JourneyScreenState extends State<JourneyScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  Path? _path;
  final noOfSlides = 4;
  final bgWidth = SizeConfig.width;
  final bgHeight = SizeConfig.width! * 2.04;
  double? fullBGHeight;

  @override
  void initState() {
    fullBGHeight = bgHeight * noOfSlides;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    log(SizeConfig.height.toString());
    log(SizeConfig.width.toString());
    _path = drawPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            _controller!.isAnimating
                ? _controller!.stop()
                : _controller!.forward();
          }),
      body: SizedBox(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          reverse: true,
          child: Container(
            height: fullBGHeight,
            width: SizeConfig.width,
            color: Colors.black,
            child: Stack(
              children: [
                SizedBox(
                  height: fullBGHeight,
                  width: SizeConfig.width,
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (ctx, i) {
                        return Image.asset(
                          "assets/custompathassets/bg.png",
                          // color: Colors.grey,
                          fit: BoxFit.cover,
                          width: bgWidth,
                          // height: bgHeight,
                        );
                      }),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(SizeConfig.width!, fullBGHeight!),
                    painter: PathPainter(_path!),
                  ),
                ),
                // Positioned(
                //   child: GestureDetector(
                //       onTap: () {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(
                //             duration: Duration(seconds: 2),
                //             content: Text("You Tapped a Tree"),
                //           ),
                //         );
                //       },
                //       child:
                //           SvgPicture.asset("assets/custompathassets/tree.svg")),
                //   bottom: bgHeight * 1 * 0.1,
                //   left: SizeConfig.width! * 0.05,
                // ),

                const CustomPath(),
                const Milestones(),
                Avatar(
                  vPos: calculateY(_animation!.value).dy,
                  hPos: calculateX(_animation!.value).dx,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Path drawPath() {
    double screenWidth = SizeConfig.width!;
    double screenHeight = fullBGHeight!;
    // Size size = Size(screenWidth!, screenHeight);
    Path path = Path()
      ..moveTo(screenWidth * 0.6, screenHeight)
      ..cubicTo(screenWidth * 0.94, screenHeight * 0.98, screenWidth,
          screenHeight * 0.94, screenWidth * 0.5, screenHeight * 0.943)
      ..cubicTo(screenWidth * 0.15, screenHeight * 0.945, 0,
          screenHeight * 0.92, screenWidth * 0.5, screenHeight * 0.91)
      ..cubicTo(screenWidth, screenHeight * 0.895, screenWidth * 0.95,
          screenHeight * 0.9, screenWidth * 0.8, screenHeight * 0.87)
      ..quadraticBezierTo(screenWidth * 0.8, screenHeight * 0.855,
          screenWidth * 0.7, screenHeight * 0.855)
      ..quadraticBezierTo(screenWidth * 0.65, screenHeight * 0.838,
          screenWidth * 0.45, screenHeight * 0.838)
      // ..lineTo(screenWidth * 0.6, screenHeight * 0.855)
      ..cubicTo(screenWidth * 0.15, screenHeight * 0.835, 0,
          screenHeight * 0.81, screenWidth * 0.5, screenHeight * 0.8)
      ..cubicTo(screenWidth, screenHeight * 0.795, screenWidth * 1.05,
          screenHeight * 0.75, screenWidth * 0.5, screenHeight * 0.75);
    return path;
  }

  Offset calculateX(value) {
    PathMetrics pathMetrics = _path!.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    // log(pathMetric.length.toString());
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }

  Offset calculateY(value) {
    PathMetrics pathMetrics = _path!.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    log(pathMetric.toString());
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
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomPath extends StatelessWidget {
  const CustomPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Image.asset("assets/custompathassets/jointer.png"),
            bottom: 195,
            left: 50),
        Positioned(
          child: Image.asset("assets/custompathassets/ladder1.png"),
          bottom: 95,
          left: 45,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/base.png"),
          bottom: 50,
          left: SizeConfig.width! / 2.6,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/path1.png"),
          bottom: 315,
          left: 140,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/base4.png"),
          bottom: 495,
          left: 83,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/path2.png"),
          bottom: 435,
          left: 140,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/base2.png"),
          bottom: 240,
          left: 80,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/base3.png"),
          bottom: 400,
          left: 230,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ladder2.png"),
          bottom: 550,
          left: 90,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/base5.png"),
          bottom: 615,
          left: 5,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/pebbles.png"),
          bottom: 650,
          left: 100,
        ),
        Positioned(
          child: Transform(
            alignment: Alignment.center,
            child: Image.asset("assets/custompathassets/path2.png"),
            transform: Matrix4.rotationY(math.pi),
          ),
          bottom: 835,
          left: 140,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/base6.png"),
          bottom: 755,
          left: 25,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/path2.png"),
          bottom: 725,
          left: 155,
        ),
        Positioned(
          child: Transform.scale(
            scale: 0.8,
            child: Image.asset("assets/custompathassets/base2.png"),
          ),
          bottom: 660,
          left: 230,
        ),
      ],
    );
  }
}

class Milestones extends StatelessWidget {
  const Milestones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text("You Tapped first milestone"),
                ),
              );
            },
            child: Image.asset("assets/custompathassets/ml0.png"),
          ),
          bottom: 95,
          left: SizeConfig.width! / 2.1,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml1.png"),
          bottom: 280,
          left: 135,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml2.png"),
          bottom: 430,
          left: 260,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml3.png"),
          bottom: 520,
          left: 105,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml4.png"),
          bottom: 640,
          left: 40,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml5.png"),
          bottom: 700,
          left: 280,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml6.png"),
          bottom: 820,
          left: 70,
        ),
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final double hPos, vPos;
  const Avatar({Key? key, required this.hPos, required this.vPos})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: vPos,
      left: hPos,
      child: const CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/fello-dev-station.appspot.com/o/test%2Favatar.png?alt=media&token=bab2c849-7694-41c4-9c34-1ab022799bfd"),
      ),
    );
  }
}

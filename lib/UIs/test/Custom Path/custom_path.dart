import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                        return SvgPicture.asset(
                          i % 2 == 0
                              ? "assets/custompathassets/bg1.svg"
                              : "assets/custompathassets/bg2.svg",
                          width: bgWidth,
                          height: bgHeight,
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
                Positioned(
                  child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text("You Tapped a Tree"),
                          ),
                        );
                      },
                      child:
                          SvgPicture.asset("assets/custompathassets/tree.svg")),
                  bottom: bgHeight * 1 * 0.1,
                  left: SizeConfig.width! * 0.05,
                ),
                Positioned(
                  top: calculateY(_animation!.value).dy,
                  left: calculateX(_animation!.value).dx,
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/fello-dev-station.appspot.com/o/test%2Favatar.png?alt=media&token=bab2c849-7694-41c4-9c34-1ab022799bfd"),
                  ),
                ),
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

import 'dart:developer';
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
    log(SizeConfig.height.toString());
    log(SizeConfig.width.toString());
    _path = drawPath();
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            height: SizeConfig.height! * 4,
            width: SizeConfig.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://img.freepik.com/free-photo/landscape-tropical-green-forest_181624-30814.jpg?t=st=1650979519~exp=1650980119~hmac=84e85546784bcfada1418551efbcba25b6568eb29df0729307bcbdfa637b6097&w=1800"),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(SizeConfig.width!, SizeConfig.height!),
                    painter: PathPainter(_path!),
                  ),
                ),
                Positioned(
                    top: SizeConfig.height! * 3 +
                        calculateY(_animation!.value).dy,
                    left: calculateX(_animation!.value).dx,
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                          "https://cdn-icons.flaticon.com/png/512/2202/premium/2202112.png?token=exp=1651060697~hmac=cda480a2e7fb04d234469475db03456b"),
                    )
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   width: 20,
                    //   height: 20,
                    // ),
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
    double? screenWidth = SizeConfig.width;
    double? screenHeight = SizeConfig.height!;
    Size size = Size(screenWidth!, screenHeight);
    Path path = Path()
      ..moveTo(size.width / 2, size.height * 0.9)
      ..cubicTo(0, size.height * 0.8, 0, size.height * 0.65, size.width * 0.6,
          size.height * 0.57)
      ..cubicTo(size.width, size.height * 0.5, size.width, size.height * 0.3,
          size.width * 0.2, size.height * 0.3);

    // ..quadraticBezierTo(size.width * 1.5, size.height * 0.8, size.width * 0.5,
    //     size.height * 0.9)

    // path.lineTo(size.width / 2, size.height * 0.8);
    // path.moveTo(size.width * 0.2, size.height * 0.9);

    // path.quadraticBezierTo(
    //     -1.5, size.height * 0.6, size.width * 0.8, size.height * 0.6);
    // path.quadraticBezierTo(size.width * 1.5, size.height * 0.4,
    //     size.width * 0.2, size.height * 0.5);
    // path.quadraticBezierTo(
    //     -1.5, size.height * 0.2, size.width * 0.8, size.height * 0.4);
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
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

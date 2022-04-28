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

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 15000));
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
    final screenHeight = SizeConfig.height! * 4;
    log("X: ${calculateX(_animation!.value).dx.toString()} Y: ${calculateY(_animation!.value).dy.toString()}");
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
            color: Colors.black,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(
            //         "https://img.freepik.com/free-photo/landscape-tropical-green-forest_181624-30814.jpg?t=st=1650979519~exp=1650980119~hmac=84e85546784bcfada1418551efbcba25b6568eb29df0729307bcbdfa637b6097&w=1800"),
            //     fit: BoxFit.fitHeight,
            //   ),
            // ),
            child: Stack(
              children: [
                SizedBox(
                  height: SizeConfig.height! * 4,
                  width: SizeConfig.width,
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (ctx, i) {
                        return SvgPicture.asset(
                          i % 2 == 0
                              ? "assets/custompathassets/bg1.svg"
                              : "assets/custompathassets/bg2.svg",
                          width: SizeConfig.width,
                        );
                      }),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(SizeConfig.width!, SizeConfig.height! * 4),
                    painter: PathPainter(_path!),
                  ),
                ),
                Positioned(
                  top:
                      SizeConfig.height! * 3 + calculateY(_animation!.value).dy,
                  left: calculateX(_animation!.value).dx,
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/fello-dev-station.appspot.com/o/test%2Favatar.png?alt=media&token=bab2c849-7694-41c4-9c34-1ab022799bfd"),
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
                  bottom: screenHeight * 0.02,
                  left: SizeConfig.width! * 0.05,
                )
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.red,
                //       borderRadius: BorderRadius.circular(10)),
                //   width: 20,
                //   height: 20,

                //),
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
    double screenHeight = SizeConfig.height! * 4;
    // Size size = Size(screenWidth!, screenHeight);
    Path path = Path()
      ..moveTo(screenWidth * 0.6, screenHeight)
      ..cubicTo(screenWidth * 0.9, screenHeight * 0.98, screenWidth,
          screenHeight * 0.955, screenWidth * 0.5, screenHeight * 0.95)
      ..cubicTo(screenWidth * 0.15, screenHeight * 0.95, 0, screenHeight * 0.93,
          screenWidth * 0.5, screenHeight * 0.92)
      ..cubicTo(screenWidth, screenHeight * 0.91, screenWidth,
          screenHeight * 0.9, screenWidth * 0.85, screenHeight * 0.885)
      ..quadraticBezierTo(screenWidth * 0.85, screenHeight * 0.86,
          screenWidth * 0.7, screenHeight * 0.863)
      ..lineTo(screenWidth * 0.6, screenHeight * 0.855)
      ..cubicTo(screenWidth * 0.15, screenHeight * 0.85, 0, screenHeight * 0.82,
          screenWidth * 0.5, screenHeight * 0.815)
      ..cubicTo(screenWidth, screenHeight * 0.81, screenWidth,
          screenHeight * 0.77, screenWidth * 0.5, screenHeight * 0.77);

    // ..quadraticBezierTo(screenWidth * 1.5, screenHeight * 0.8, screenWidth * 0.5,
    //     screenHeight * 0.9)

    // path.lineTo(screenWidth / 2, screenHeight * 0.8);
    // path.moveTo(screenWidth * 0.2, screenHeight * 0.9);

    // path.quadraticBezierTo(
    //     -1.5, screenHeight * 0.6, screenWidth * 0.8, screenHeight * 0.6);
    // path.quadraticBezierTo(screenWidth * 1.5, screenHeight * 0.4,
    //     screenWidth * 0.2, screenHeight * 0.5);
    // path.quadraticBezierTo(
    //     -1.5, screenHeight * 0.2, screenWidth * 0.8, screenHeight * 0.4);
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
      ..strokeWidth = 30.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

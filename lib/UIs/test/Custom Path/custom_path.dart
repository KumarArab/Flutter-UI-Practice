import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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
  ScrollController? _mainController;
  Animation? _animation;
  Path? _path;
  final noOfSlides = 4;
  final bgWidth = SizeConfig.width;
  final bgHeight = SizeConfig.width! * 2.04;
  double? fullBGHeight;
  double _yOffset = 0;
  double? _avatarTopOffset;
  double? _avatarLeftOffset;

  List<CustomPathModel> customPathData = [
    CustomPathModel(pathType: PathType.move, cords: [0.6, 1], slide: 1),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [0.94, 0.92, 1, 0.78, 0.5, 0.775],
        slide: 1),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [0.15, 0.775, 0, 0.7, 0.5, 0.64],
        slide: 1),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [1, 0.59, 0.95, 0.6, 0.8, 0.48],
        slide: 1),
    CustomPathModel(
        pathType: PathType.quadratic, cords: [0.8, 0.43, 0.7, 0.42], slide: 1),
    CustomPathModel(
        pathType: PathType.quadratic,
        cords: [0.65, 0.35, 0.45, 0.35],
        slide: 1),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [0.15, 0.35, 0, 0.22, 0.5, 0.2],
        slide: 1),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [1, 0.18, 1.05, 0.02, 0.6, 0],
        slide: 1),
    //newpath
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [0.94, 0.92, 1, 0.78, 0.5, 0.775],
        slide: 2),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [0.15, 0.775, 0, 0.7, 0.5, 0.64],
        slide: 2),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [1, 0.59, 0.95, 0.6, 0.8, 0.48],
        slide: 2),
    CustomPathModel(
        pathType: PathType.quadratic, cords: [0.8, 0.43, 0.7, 0.42], slide: 2),
    CustomPathModel(
        pathType: PathType.quadratic,
        cords: [0.65, 0.35, 0.45, 0.35],
        slide: 2),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [0.15, 0.35, 0, 0.22, 0.5, 0.2],
        slide: 2),
    CustomPathModel(
        pathType: PathType.cubic,
        cords: [1, 0.18, 1.05, 0.02, 0.6, 0],
        slide: 2),
  ];

  @override
  void initState() {
    fullBGHeight = bgHeight * noOfSlides;
    _avatarTopOffset = fullBGHeight! - 60;
    _avatarLeftOffset = SizeConfig.width! / 2;
    _mainController = ScrollController();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        animationBehavior: AnimationBehavior.preserve);
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeOutCubic),
    )..addListener(() {
        setState(() {});
        _avatarLeftOffset = calculateX(_animation!.value).dx;
        _avatarTopOffset = calculateY(_animation!.value).dy;
        _mainController!.animateTo(_yOffset - SizeConfig.height! / 2,
            duration: const Duration(seconds: 10), curve: Curves.linear);
      });

    _mainController!.addListener(() {
      log((_mainController!.offset + SizeConfig.height!).toString());
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
          controller: _mainController,
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
                  child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text("You journey starts here!!"),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                          "assets/custompathassets/board.svg")),
                  bottom: bgHeight * 1 * 0.05,
                  left: SizeConfig.width! * 0.5,
                ),
                Positioned(
                  child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text("This is a flower"),
                          ),
                        );
                      },
                      child: Lottie.asset("assets/lotties/flower.json",
                          height: SizeConfig.width! * 0.24)),
                  bottom: bgHeight * 1 * 0.4,
                  left: SizeConfig.width! * 0.5,
                ),
                Positioned(
                  child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text("This is a plant"),
                          ),
                        );
                      },
                      child: Lottie.asset("assets/lotties/plant.json",
                          height: SizeConfig.width! * 0.32)),
                  bottom: bgHeight * 1 * 0.45,
                  left: SizeConfig.width! * 0.1,
                ),
                Positioned(
                  top: _avatarTopOffset,
                  left: _avatarLeftOffset,
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
    _mainController!.dispose();
    super.dispose();
  }

  Path drawPath() {
    double screenWidth = SizeConfig.width!;
    double screenHeight = fullBGHeight! / noOfSlides;
    // Size size = Size(screenWidth!, screenHeight);
    Path path = Path();
    for (int i = 0; i < customPathData.length; i++) {
      path = generateCustomPath(
          path, customPathData[i], screenHeight, screenWidth, noOfSlides);
    }
    return path;
  }

  Path generateCustomPath(Path path, CustomPathModel model, double screenHeight,
      double screenWidth, int slides) {
    switch (model.pathType) {
      case PathType.linear:
        return path;
      case PathType.arc:
        return path;
      case PathType.move:
        path.moveTo(
            screenWidth * model.cords[0],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[1]);
        return path;
      case PathType.rect:
        return path;
      case PathType.quadratic:
        path.quadraticBezierTo(
            screenWidth * model.cords[0],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[1],
            screenWidth * model.cords[2],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[3]);
        return path;
      case PathType.cubic:
        path.cubicTo(
            screenWidth * model.cords[0],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[1],
            screenWidth * model.cords[2],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[3],
            screenWidth * model.cords[4],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[5]);
        return path;
      default:
        return path;
    }
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
    _yOffset = pos!.position.dy;
    return pos.position;
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

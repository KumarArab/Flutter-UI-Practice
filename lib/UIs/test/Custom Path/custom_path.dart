import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/active_milestone.dart';
import 'package:testapp/UIs/test/Custom%20Path/addons_path_painters.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:testapp/UIs/test/Custom%20Path/path_painters.dart';
import 'package:testapp/UIs/test/Custom%20Path/stage_painters.dart';
import 'package:testapp/utils/size_config.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

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
  ScrollController? _mainController;
  Animation? _animation;
  Path? _path;
  final noOfSlides = 2;
  final bgWidth = SizeConfig.width;
  final bgHeight = SizeConfig.width! * 2.165;
  double? fullBGHeight;
  double _yOffset = 0;
  double? _avatarTopOffset;
  double? _avatarLeftOffset;
  double bgZoom = 1.5;

  List<List<CustomPathModel>>? customPathData = [
    [
      CustomPathModel(pathType: PathType.move, cords: [0.5, 0.88], slide: 1),
    ],
    [
      CustomPathModel(pathType: PathType.linear, cords: [0.3, 0.73], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.2, 0.7], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.33, 0.66], slide: 1),
    ],
    [
      CustomPathModel(pathType: PathType.linear, cords: [0.5, 0.59], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.67, 0.47], slide: 1),
    ],
    [
      CustomPathModel(
          pathType: PathType.linear, cords: [0.74, 0.445], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.4, 0.34], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.26, 0.3], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.26, 0.2], slide: 1),
    ],
    [
      CustomPathModel(pathType: PathType.linear, cords: [0.2, 0.18], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.72, 0.12], slide: 1),
    ],
    [
      CustomPathModel(pathType: PathType.linear, cords: [0.8, 0.09], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.5, 0.0], slide: 1),
      CustomPathModel(pathType: PathType.linear, cords: [0.44, 0.98], slide: 2),
    ],
    [
      CustomPathModel(pathType: PathType.linear, cords: [0.35, 0.95], slide: 2),
      CustomPathModel(pathType: PathType.linear, cords: [0.7, 0.835], slide: 2),
    ]
  ];

  @override
  void initState() {
    fullBGHeight = bgHeight * noOfSlides;
    _avatarTopOffset = fullBGHeight! - SizeConfig.height! * 0.12;
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
        // _mainController!.animateTo(_yOffset - SizeConfig.height! / 2,
        //     duration: const Duration(seconds: 14), curve: Curves.linear);
      });

    _mainController!.addListener(() {
      log((_mainController!.offset + SizeConfig.height!).toString());
    });
    log(SizeConfig.height.toString());
    log(SizeConfig.width.toString());
    _path = drawPath();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _mainController!.animateTo(_mainController!.position.maxScrollExtent,
          duration: const Duration(seconds: 3), curve: Curves.easeInCubic);
      setState(() {
        bgZoom = 1;
      });
    });
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
          // reverse: true,
          child: Container(
            height: fullBGHeight,
            width: SizeConfig.width,
            color: Colors.black,
            child: Stack(
              children: [
                AnimatedScale(
                  alignment: Alignment.center,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeOutCubic,
                  scale: bgZoom,
                  child: Background(
                      fullBGHeight: fullBGHeight,
                      noOfSlides: noOfSlides,
                      bgWidth: bgWidth,
                      bgHeight: bgHeight),
                ),
                CustomPath(),
                //const Milestones(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(SizeConfig.width!, fullBGHeight!),
                    painter: PathPainter(_path!),
                  ),
                ),
                Avatar(
                  vPos: calculateY(_animation!.value).dy,
                  hPos: calculateX(_animation!.value).dx,
                ),
                // Positioned(
                //   left: bgWidth! * 0.3653,
                //   bottom: bgHeight * 0.0996,
                //   child: Container(
                //     height: 200,
                //     width: 1,
                //     color: Colors.red,
                //   ),
                // )
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
    for (int i = 0; i < customPathData!.length; i++) {
      for (int j = 0; j < customPathData![i].length; j++) {
        path = generateCustomPath(
            path, customPathData![i][j], screenHeight, screenWidth, noOfSlides);
      }
    }
    return path;
  }

  Path generateCustomPath(Path path, CustomPathModel model, double screenHeight,
      double screenWidth, int slides) {
    switch (model.pathType) {
      case PathType.linear:
        path.lineTo(
            screenWidth * model.cords[0],
            screenHeight * (slides - model.slide).abs() +
                screenHeight * model.cords[1]);
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

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.fullBGHeight,
    required this.noOfSlides,
    required this.bgWidth,
    required this.bgHeight,
  }) : super(key: key);

  final double? fullBGHeight;
  final int noOfSlides;
  final double? bgWidth, bgHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: fullBGHeight,
      width: SizeConfig.width,
      child: Column(
        children: List.generate(
          noOfSlides,
          (index) => Image.asset(
            "assets/custompathassets/bg.png",
            // color: Colors.grey,
            fit: BoxFit.cover,
            width: bgWidth,
            height: bgHeight,
          ),
        ),
      ),
    );
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
  CustomPath({Key? key}) : super(key: key);

  final bgWidth = SizeConfig.width;
  final bgHeight = SizeConfig.width! * 2.165;
  final List<PathItemModel> _customPathItemsList = [
    PathItemModel(
      asset: "assets/custompathassets/base1.svg",
      colors: [],
      dx: 0.3653,
      dy: 0.0966,
      page: 1,
      width: 0.2873,
      height: 0.0985,
      dz: 2,
      level: 1,
      isBase: true,
      source: "AST",
      type: "SVG",
    ),
    PathItemModel(
      asset: "assets/custompathassets/ladder_f.svg",
      colors: [Colors.grey, Colors.amber, Colors.amberAccent],
      dx: 0.0992,
      dy: 0.1527,
      page: 1,
      width: 0.5262,
      height: 0.1551,
      dz: 1,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/p2.svg", // "jointer",
      colors: const [
        Color(0xff5A4A33),
        Color(0xffF79780),
        Color(0xffFFD4AC),
      ],
      dx: 0.108,
      dy: 0.2762,
      page: 1,
      width: 0.2674,
      height: 0.0991,
      dz: 0,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/base2.svg",
      colors: [],
      dx: 0.235,
      dy: 0.328,
      page: 1,
      width: 0.435,
      height: 0.1314,
      dz: 2,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/p3.svg",
      colors: [],
      dx: 0.4026,
      dy: 0.4174,
      page: 1,
      width: 0.4905,
      height: 0.1429,
      dz: 1,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/base3.svg",
      colors: [],
      dx: 0.648,
      dy: 0.521,
      page: 1,
      width: 0.2948,
      height: 0.0894,
      dz: 2,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/path4.svg",
      colors: [],
      dx: 0.3933,
      dy: 0.5757,
      page: 1,
      width: 0.3674,
      height: 0.1151,
      dz: 1,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/base4.svg",
      colors: [],
      dx: 0.2426,
      dy: 0.6511,
      page: 1,
      width: 0.2598,
      height: 0.0847,
      dz: 0,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/path5.svg",
      colors: [],
      dx: 0.2586,
      dy: 0.713,
      page: 1,
      width: 0.0696,
      height: 0.1046,
      dz: 0,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/base5.svg",
      colors: [],
      dx: 0.0453,
      dy: 0.7936,
      page: 1,
      width: 0.3378,
      height: 0.0992,
      dz: 0,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/path6.svg",
      colors: [],
      dx: 0.2533,
      dy: 0.8559,
      page: 1,
      width: 0.4853,
      height: 0.0677,
      dz: 0,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/base6.svg",
      colors: [],
      dx: 0.6613,
      dy: 0.8743,
      page: 1,
      width: 0.3386,
      height: 0.1133,
      dz: 4,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/path7.svg",
      colors: [],
      dx: 0.5013,
      dy: 0.9362,
      page: 1,
      width: 0.2805,
      height: 0.0822,
      dz: 3,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/base7.svg",
      colors: [],
      dx: 0.128,
      dy: 0.9381,
      page: 1,
      width: 0.4506,
      height: 0.1328,
      dz: 2,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
    PathItemModel(
      asset: "assets/custompathassets/path8.svg",
      colors: [],
      dx: 0.4346,
      dy: 1.0328,
      page: 1,
      width: 0.2961,
      height: 0.0947,
      dz: 1,
      level: 1,
      isBase: true,
      source: "AST",
      type: 'SVG',
    ),
  ];

  getChild(PathItemModel item) {
    log(item.height.toString());
    log(item.width.toString());
    switch (item.type) {
      case "SVG":
        return item.source == "NTWRK"
            ? SvgPicture.network(
                item.asset!,
                height: item.height,
                width: item.width,
              )
            : SvgPicture.asset(
                item.asset!,
                width: bgWidth! * item.width!,
                height: bgHeight * item.height!,
              );
      case "PNG":
        return item.source == "NTWRK"
            ? Image.network(
                item.asset!,
                height: item.height,
                width: item.width,
              )
            : Image.asset(
                item.asset!,
                width: bgWidth! * item.width!,
                height: bgHeight * item.height!,
              );
      case "CSP":
        return CustomPaint(
          size: Size(bgWidth! * item.width!, bgHeight * item.height!),
          painter: getPainter(item),
        );
    }
  }

  getPainter(PathItemModel item) {
    switch (item.asset) {
      case "jointer":
        return JointerPainter(
          // shadowColor: const Color(0xff5A4A33),
          // ladderPrimaryColor: const Color(0xffF79780),
          // ladderSecondaryColor: const Color(0xffFFD4AC),
          shadowColor: item.colors?[0],
          gradColor1: item.colors?[1],
          gradColor2: item.colors?[2],
        );
      case "ladder":
        return LadderPainter(
          shadowColor: item.colors?[0], //const Color(0xff5A4A33),
          ladderPrimaryColor: item.colors?[1], //const Color(0xffF79780),
          ladderSecondaryColor: item.colors?[2], //const Color(0xffFFD4AC),
          // shadowColor: Colors.grey,
          // ladderPrimaryColor: Colors.amber,
          // ladderSecondaryColor: Colors.amberAccent,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    _customPathItemsList.sort((a, b) => a.dz!.compareTo(b.dz!));
    return Stack(
      children: List.generate(
        _customPathItemsList.length,
        (i) => Positioned(
          left: bgWidth! * _customPathItemsList[i].dx!,
          bottom: bgHeight * _customPathItemsList[i].dy!,
          child: Container(
            width: bgWidth! * _customPathItemsList[i].width!,
            height: bgHeight * _customPathItemsList[i].height!,
            decoration: BoxDecoration(
              //color: i == 0 ? Colors.red : Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.bottomCenter,
            child: getChild(_customPathItemsList[i]),
          ),
        ),
      ),
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
                print("You tapped level 0");
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You tapped level 0")));
              },
              child: Image.asset("assets/custompathassets/ml0.png")),
          bottom: 95,
          left: SizeConfig.width! / 2.1,
        ),
        const ActiveFloatingMilestone(
          png: "assets/custompathassets/ml1.png",
          dy: 280,
          dx: 135,
        ),
        const ActiveFloatingMilestone(
          png: "assets/custompathassets/ml2.png",
          dy: 430,
          dx: 260,
        ),
        const ActiveRotatingMilestone(
          png: "assets/custompathassets/ml3.png",
          dy: 520,
          dx: 105,
        ),
        Positioned(
          child: Image.asset("assets/custompathassets/ml4.png"),
          bottom: 640,
          left: 40,
        ),
        const ActiveFloatingMilestone(
          png: "assets/custompathassets/ml5.png",
          dy: 700,
          dx: 280,
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
      child: const IgnorePointer(
        ignoring: true,
        child: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/fello-dev-station.appspot.com/o/test%2Favatar.png?alt=media&token=bab2c849-7694-41c4-9c34-1ab022799bfd"),
        ),
      ),
    );
  }
}

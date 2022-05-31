import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testapp/UIs/test/Custom%20Path/active_milestone.dart';
import 'package:testapp/UIs/test/Custom%20Path/addons_path_painters.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_data.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:testapp/UIs/test/Custom%20Path/path_painters.dart';
import 'package:testapp/utils/size_config.dart';

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
  double? bgWidth = SizeConfig.width;
  double? bgHeight = SizeConfig.width! * 2.165;
  double? fullBGHeight;
  double bgZoom = 1.5;

  @override
  void initState() {
    fullBGHeight = bgHeight! * noOfSlides;
    // _avatarTopOffset = fullBGHeight! - SizeConfig.height! * 0.12;
    // _avatarLeftOffset = SizeConfig.width! / 2;
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
        // _avatarLeftOffset = calculateX(_animation!.value).dx;
        // _avatarTopOffset = calculateY(_animation!.value).dy;
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

  setDimensions(BuildContext context) {
    bgHeight = MediaQuery.of(context).size.width * 2.165;
    bgWidth = MediaQuery.of(context).size.width;
    fullBGHeight = bgHeight! * noOfSlides;
  }

  @override
  Widget build(BuildContext context) {
    // setDimensions(context);
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
                    bgHeight: bgHeight,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(SizeConfig.width!, fullBGHeight!),
                    painter: PathPainter(_path!),
                  ),
                ),
                CustomPath(),
                Milestones(),
                Avatar(
                  vPos: calculateY(_animation!.value).dy,
                  hPos: calculateX(_animation!.value).dx,
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
    for (int i = 0; i < customPathData!.length; i++) {
      for (int j = 0; j < customPathData![i].length; j++) {
        path = generateCustomPath(
            path, customPathData![i][j], screenHeight, screenWidth, noOfSlides);
      }
    }
    return path;
  }

  Path generateCustomPath(Path path, CustomPathModel model, double screenHeight,
      double screenWidth, int pages) {
    switch (model.pathType) {
      case PathType.linear:
        path.lineTo(
            screenWidth * model.cords[0],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[1]);
        return path;
      case PathType.arc:
        return path;
      case PathType.move:
        path.moveTo(
            screenWidth * model.cords[0],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[1]);
        return path;
      case PathType.rect:
        return path;
      case PathType.quadratic:
        path.quadraticBezierTo(
            screenWidth * model.cords[0],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[1],
            screenWidth * model.cords[2],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[3]);
        return path;
      case PathType.cubic:
        path.cubicTo(
            screenWidth * model.cords[0],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[1],
            screenWidth * model.cords[2],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[3],
            screenWidth * model.cords[4],
            screenHeight * (pages - model.page).abs() +
                screenHeight * model.cords[5]);
        return path;
      default:
        return path;
    }
  }

  Offset calculateX(value) {
    PathMetrics pathMetrics = _path!.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
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

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomPath extends StatelessWidget {
  CustomPath({Key? key}) : super(key: key);

  final bgWidth = SizeConfig.width;
  final bgHeight = SizeConfig.width! * 2.165;

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
    customPathItemsList.sort((a, b) => a.dz!.compareTo(b.dz!));
    return Stack(
      children: List.generate(
        customPathItemsList.length,
        (i) => Positioned(
          left: bgWidth! * customPathItemsList[i].dx!,
          bottom: bgHeight * customPathItemsList[i].dy!,
          child: Container(
            width: bgWidth! * customPathItemsList[i].width!,
            height: bgHeight * customPathItemsList[i].height!,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            //         .withOpacity(1.0),
            //     width: 1,
            //   ),
            //   // borderRadius: BorderRadius.circular(10),
            // ),
            alignment: Alignment.bottomCenter,
            child: getChild(customPathItemsList[i]),
          ),
        ),
      ),
    );
  }
}

class Milestones extends StatelessWidget {
  const Milestones({Key? key}) : super(key: key);
  getMilestoneType(MilestoneModel milestone) {
    switch (milestone.animType) {
      case "ROTATE":
        return ActiveRotatingMilestone(milestone: milestone);
      case "FLOAT":
        return ActiveFloatingMilestone(milestone: milestone);
      default:
        return StaticMilestone(milestone: milestone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        milestones.length,
        (i) => getMilestoneType(
          milestones[i],
        ),
      ),
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

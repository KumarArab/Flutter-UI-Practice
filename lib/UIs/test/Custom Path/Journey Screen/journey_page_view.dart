import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/Journey%20page%20elements/jAssetPath.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/Journey%20page%20elements/jBackground.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/Journey%20page%20elements/jMilestones.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_logic.dart';
import 'package:testapp/UIs/test/Custom%20Path/active_milestone.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_data.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:testapp/utils/size_config.dart';

final avatarKey = GlobalKey();

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
  Offset? _avatarPosition;

  @override
  void initState() {
    super.initState();
    JourneyPageLogic(0, 2, pages);
    _mainController = ScrollController();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        animationBehavior: AnimationBehavior.preserve);
    _path = JourneyPageLogic.drawPath();
    _avatarPosition = calculatePosition(0);
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeInOutCubic),
    )..addListener(() {
        setState(() {});
        _avatarPosition = calculatePosition(_animation!.value);
        log("Avatar Position( ${_avatarPosition!.dx} , ${_avatarPosition!.dy} )");
        double avatarPositionFromBottom =
            JourneyPageLogic.currentFullViewHeight! - _avatarPosition!.dy;
        double scrollPostion =
            JourneyPageLogic.currentFullViewHeight! - _mainController!.offset;
        if (avatarPositionFromBottom >= scrollPostion) {
          _mainController!.animateTo(
              scrollPostion - JourneyPageLogic.pageHeight! * 0.5,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutCubic);
        }
        // log("Avatar Position( $avatarPositionFromBottom , $scrollPostion )");
        //if(scrollOffsetfromBottom >= avatarBottomOffset) avatar is hidden
        //
      });
    _mainController!.addListener(() {
      // Scrollable.ensureVisible(avatarKey.currentContext!);
      // log(_mainController!.offset.toString());
      double avatarPositionFromBottom =
          JourneyPageLogic.currentFullViewHeight! - _avatarPosition!.dy;
      double scrollPostion =
          JourneyPageLogic.currentFullViewHeight! - _mainController!.offset;
      log("Avatr to Scroll Ratio( $avatarPositionFromBottom , $scrollPostion )");
    });
    log("Screen: Height: ${SizeConfig.height}");
    log("Screen Width: ${SizeConfig.width}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mainController!.animateTo(_mainController!.position.maxScrollExtent,
          duration: const Duration(seconds: 3), curve: Curves.easeInCubic);
    });
  }

  @override
  Widget build(BuildContext context) {
    // setDimensions(context);
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            if (_controller!.isCompleted)
              _controller!.reverse();
            else if (_controller!.isAnimating)
              _controller!.stop();
            else {
              _controller!.forward();
            }
          }),
      body: SizedBox(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: SingleChildScrollView(
          controller: _mainController!,
          physics: const ClampingScrollPhysics(),
          // reverse: true,
          child: Container(
            height: JourneyPageLogic.currentFullViewHeight,
            width: SizeConfig.width,
            color: Colors.black,
            child: Stack(
              children: [
                const Background(),
                const JourneyAssetPath(),
                const Milestones(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(SizeConfig.width!,
                        JourneyPageLogic.currentFullViewHeight!),
                    painter: PathPainter(_path!),
                  ),
                ),
                Avatar(
                  vPos: _avatarPosition!.dy,
                  hPos: _avatarPosition!.dx,
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

  // Offset calculateX(value) {
  //   PathMetrics pathMetrics = _path!.computeMetrics();
  //   PathMetric pathMetric = pathMetrics.elementAt(0);
  //   value = pathMetric.length * value;
  //   Tangent? pos = pathMetric.getTangentForOffset(value);
  //   return pos!.position;
  // }

  Offset calculatePosition(value) {
    PathMetrics pathMetrics = _path!.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }
}

class Avatar extends StatelessWidget {
  final double hPos, vPos;
  const Avatar({Key? key, required this.hPos, required this.vPos})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: avatarKey,
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

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

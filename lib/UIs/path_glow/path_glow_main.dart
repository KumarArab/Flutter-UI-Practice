import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:testapp/utils/size_config.dart';

class PathGlowMain extends StatelessWidget {
  const PathGlowMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C5462),
      body: Center(
        child: SizedBox(
          child: Stack(
            children: [
              const ActiveMilestoneBackgroundGlow(),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/custompathassets/base1.svg",
                  height: 200,
                  width: 200,
                ),
              ),
              ActiveMilestoneBaseGlow(
                point:
                    Point(SizeConfig.width! * 0.25, SizeConfig.height! * 0.28),
                size: Size(SizeConfig.width! * 0.5, SizeConfig.width! * 0.6),
              ),
              Positioned(
                top: SizeConfig.height! * 0.36,
                left: SizeConfig.width! * 0.4,
                child: SvgPicture.asset("assets/custompathassets/ml4.svg",
                    height: 100, width: 100, fit: BoxFit.contain),
              ),
              const ActiveMilestoneFrontGlow(),
              const MileStoneCheck()
            ],
          ),
        ),
      ),
    );
  }
}

class MileStoneCheck extends StatelessWidget {
  const MileStoneCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: SizeConfig.width! * 0.54,
      top: SizeConfig.height! * 0.46,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xff0C5462), width: 4),
          color: Colors.black,
        ),
        child: const Icon(Icons.check, color: Color(0xff62E3C4)),
      ),
    );
  }
}

class ActiveMilestoneFrontGlow extends StatelessWidget {
  const ActiveMilestoneFrontGlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: SizeConfig.width! * 0.3,
        top: SizeConfig.height! * 0.42,
        child: ClipPath(
          clipper: const FrontBeamClipper(),
          child: Container(
            width: SizeConfig.width! * 0.4,
            height: SizeConfig.width! * 0.2,
            decoration: BoxDecoration(
              // color: Colors.black,
              gradient: LinearGradient(colors: [
                const Color(0xff62E3C4).withOpacity(0.01),
                const Color(0xff62E3C4).withOpacity(0.5),
                const Color(0xff62E3C4).withOpacity(0.3),
                const Color(0xff62E3C4).withOpacity(0.1),
                const Color(0xff62E3C4).withOpacity(0.01)
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
        ));
  }
}

class ActiveMilestoneBackgroundGlow extends StatelessWidget {
  const ActiveMilestoneBackgroundGlow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: SizeConfig.width! * 0.7,
        width: SizeConfig.width! * 0.7,
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: const Color(0xff62E3C4).withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: SizeConfig.width! * 0.5,
              offset: const Offset(0, 0))
        ]),
      ),
    );
  }
}

class ActiveMilestoneBaseGlow extends StatelessWidget {
  final Point? point;
  final Size? size;

  const ActiveMilestoneBaseGlow({Key? key, this.point, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: point!.x.toDouble(),
      top: point!.y.toDouble(),
      child: SizedBox(
        width: size!.width,
        height: size!.height,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: ClipPath(
                  clipper: const BackBeamClipper(),
                  child: Container(
                    width: SizeConfig.width! * 0.5,
                    height: SizeConfig.width! * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xff62E3C4).withOpacity(0.01),
                            const Color(0xff62E3C4).withOpacity(0.5),
                            const Color(0xff62E3C4).withOpacity(0.3),
                            const Color(0xff62E3C4).withOpacity(0.1),
                            const Color(0xff62E3C4).withOpacity(0.01)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: BaseRings(
                size: SizeConfig.width! * 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BaseRings extends StatelessWidget {
  final double? size;

  const BaseRings({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationX(math.pi / 4),
      alignment: Alignment.center,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 9, color: Colors.white),
                    shape: BoxShape.circle),
                height: size! * 0.4,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 6, color: Colors.white.withOpacity(0.8)),
                    shape: BoxShape.circle),
                height: size! * 0.7,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 5, color: Colors.white.withOpacity(0.6)),
                    shape: BoxShape.circle),
                height: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackBeamClipper extends CustomClipper<Path> {
  const BackBeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(0, 0)
      ..lineTo(size.width * 0.2, size.height)
      ..lineTo(size.width * 0.8, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

class FrontBeamClipper extends CustomClipper<Path> {
  const FrontBeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(0, 0)
      ..lineTo(size.width * 0.1, size.height)
      ..lineTo(size.width * 0.9, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

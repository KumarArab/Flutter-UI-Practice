import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class PathGlowMain extends StatelessWidget {
  const PathGlowMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/custompathassets/base1.svg",
                  height: 250,
                  width: 250,
                ),
              ),
              Positioned(
                top: 25,
                left: 45,
                child: Transform(
                  transform: Matrix4.rotationX(math.pi / 4),
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 10, color: Colors.white),
                                shape: BoxShape.circle),
                            height: 80,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 5,
                                    color: Colors.white.withOpacity(0.8)),
                                shape: BoxShape.circle),
                            height: 120,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3,
                                    color: Colors.white.withOpacity(0.6)),
                                shape: BoxShape.circle),
                            height: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

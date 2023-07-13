import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieTest extends StatefulWidget {
  const LottieTest({Key? key}) : super(key: key);

  @override
  State<LottieTest> createState() => _LottieTestState();
}

class _LottieTestState extends State<LottieTest>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottie Text"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lotties/circle.json",
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
          ),
          MaterialButton(
            onPressed: () {
              timer = Timer.periodic(
                  Duration(
                      milliseconds: _controller.duration!.inMilliseconds ~/ 2),
                  (timer) {
                _controller.animateTo(0.5);
              });
            },
            child: Text("Animate"),
          )
        ],
      ),
    );
  }
}

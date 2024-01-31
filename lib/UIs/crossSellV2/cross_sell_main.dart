import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class UpSellMain extends StatefulWidget {
  const UpSellMain({Key? key}) : super(key: key);

  @override
  State<UpSellMain> createState() => _UpSellMainState();
}

class _UpSellMainState extends State<UpSellMain> with SingleTickerProviderStateMixin {
  static const primary = Color(0xFF63D9C8);
  static const primaryLight = Color(0xFFE4F8F5);

  late AnimationController _controller;
  late BorderRadiusTween borderRadius;

  late double _height, min = 0.15, initial = 0.15, max = 0.75;
  double backScreenOffset = 0;
  DraggableScrollableController _draggableScrollableController = DraggableScrollableController();
  double? prevPixel;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600), reverseDuration: const Duration(milliseconds: 600));
    _draggableScrollableController.addListener(() {
      if (_draggableScrollableController.size > 0.3) {
        _controller.reset();
        _controller.stop();
        timer?.cancel();
      }
      if (_draggableScrollableController.pixels.runtimeType == double) {
        if (prevPixel == null) {
          prevPixel = _draggableScrollableController.pixels;
          backScreenOffset += 1;
        } else {
          backScreenOffset += (_draggableScrollableController.pixels - prevPixel!);
        }
        prevPixel = _draggableScrollableController.pixels;
        if (mounted) {
          // setState(() {});
        }
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
        springAnimate();
      });
    });
  }

  springAnimate() {
    _controller.forward();
    _draggableScrollableController
        .animateTo(
      0.25,
      duration: const Duration(milliseconds: 1600),
      curve: const Cubic(0.4, -0.4, 0, 1.3),
    )
        .then((value) {
      _controller.reverse();
      _draggableScrollableController.animateTo(
        0.18,
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
      );
    });
  }

  openFullModalSheet() {
    _draggableScrollableController.animateTo(
      1,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCirc,
    );
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            FadeTransition(
              opacity: _controller,
              child: Transform.translate(
                offset: const Offset(0, -80),
                child: Container(
                  height: 100,
                  width: SizeConfig.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primary.withOpacity(0.4),
                        primaryLight.withOpacity(0.05),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
            DraggableScrollableSheet(
              minChildSize: min, // 0.2 times of available height, sheet can't go below this on dragging
              maxChildSize: max, // 0.7 times of available height, sheet can't go above this on dragging
              expand: false,
              snap: true,
              controller: _draggableScrollableController,
              initialChildSize:
                  initial, // 0.1 times of available height, sheet start at this size when opened for first time
              builder: (BuildContext context, ScrollController controller) {
                return Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: openFullModalSheet,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        controller: controller,
                        child: Column(
                          children: [
                            Container(height: 400, width: SizeConfig.width, color: Colors.black),
                            Container(height: 400, width: SizeConfig.width, color: Colors.red),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              left: SizeConfig.width! / 2 - 25,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
      body: SizedBox(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: Container(
          color: Colors.white,
          width: SizeConfig.width,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                SizedBox(
                  child: Image.asset("assets/images/error.png", width: SizeConfig.width),
                ),
                const Text(
                  "Your Application is on Hold",
                  style: TextStyle(
                      // fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Thank you for showing interest in <Paychek>. Unfortunately, your application is on hold due to some loans which have been classified as bad debts in your credit report.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 1000),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

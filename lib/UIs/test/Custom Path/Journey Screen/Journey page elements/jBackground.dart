import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_logic.dart';
import 'package:testapp/utils/size_config.dart';

class Background extends StatefulWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  double bgZoom = 1.5;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        bgZoom = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      alignment: Alignment.center,
      duration: const Duration(seconds: 3),
      curve: Curves.easeOutCubic,
      scale: bgZoom,
      child: SizedBox(
        height: JourneyPageLogic.currentFullViewHeight,
        width: SizeConfig.width,
        child: Column(
          children: List.generate(
            JourneyPageLogic.pageCount!,
            (mlIndex) => Image.asset(
              "assets/custompathassets/bg.png",
              // color: Colors.grey,
              fit: BoxFit.cover,
              width: JourneyPageLogic.pageWidth,
              height: JourneyPageLogic.pageHeight,
            ),
          ),
        ),
      ),
    );
  }
}

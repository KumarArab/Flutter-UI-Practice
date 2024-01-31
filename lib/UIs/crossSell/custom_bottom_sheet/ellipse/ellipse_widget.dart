import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:testapp/UIs/crossSell/custom_bottom_sheet/cb_sheet.dart';

class EllipseWidget extends StatelessWidget {
  final width = 243.46;
  final height = 84.68;

  const EllipseWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // isnt working without container
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xff6EF19E),
        borderRadius: BorderRadius.circular(200),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: width * GOLDEN_RATIO_B,
          sigmaY: height * GOLDEN_RATIO_B,
        ),
        child: Container(),
      ),
    );
  }
}

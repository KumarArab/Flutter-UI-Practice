import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testapp/UIs/compass/compass_view_painter.dart';
import 'package:testapp/UIs/compass/neumorphism.dart';
import 'package:testapp/utils/size_config.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.width,
        height: SizeConfig.height,
        child: Neumorphism(
          margin: EdgeInsets.all(SizeConfig.width! * 0.1),
          child: CustomPaint(
            painter: CompassViewPainter(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

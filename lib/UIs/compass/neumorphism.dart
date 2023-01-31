import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testapp/UIs/compass/app_color.dart';

class Neumorphism extends StatelessWidget {
  const Neumorphism(
      {Key? key,
      required this.child,
      this.distance = 30,
      this.blur = 50,
      this.margin,
      this.padding,
      this.isReverse = false,
      this.innerShadow = false})
      : super(key: key);
  final Widget child;
  final double distance;
  final double blur;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool isReverse;
  final bool innerShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: isReverse
                ? [
                    BoxShadow(
                        color: AppColor.primaryDarkColor,
                        blurRadius: blur,
                        offset: Offset(distance, -distance)),
                    BoxShadow(
                        color: AppColor.white,
                        blurRadius: blur,
                        offset: Offset(distance, distance)),
                  ]
                : [
                    BoxShadow(
                        color: AppColor.white,
                        blurRadius: blur,
                        offset: Offset(-distance, -distance)),
                    BoxShadow(
                        color: AppColor.primaryDarkColor,
                        blurRadius: blur,
                        offset: Offset(distance, distance)),
                  ]),
        child: innerShadow
            ? Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.white,
                    ],
                  ),
                ),
              )
            : child);
  }
}

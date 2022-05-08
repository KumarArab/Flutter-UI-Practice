import 'package:flutter/cupertino.dart';

enum PathType { cubic, quadratic, linear, arc, rect, move }

class CustomPathModel {
  final PathType pathType;
  final List<double> cords;
  final int slide;

  CustomPathModel({
    required this.pathType,
    required this.cords,
    required this.slide,
  });
}

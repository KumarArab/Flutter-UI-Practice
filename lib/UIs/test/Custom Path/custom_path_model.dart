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

class MilestonesModel {
  final String asset;
  final double dx, dy;
  final List<int> rewards;
  final String description;
  final String route;
  MilestonesModel(
      this.asset, this.dx, this.dy, this.rewards, this.description, this.route);
}

class PathItemModel {
  final String asset;
  final double dx, dy;
  final int dz;
  PathItemModel(this.asset, this.dx, this.dy, this.dz);
}

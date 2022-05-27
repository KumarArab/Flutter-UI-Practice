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
  final String? asset;
  final double? dx, dy;
  final double? height, width;
  final int? dz;
  final int? page;
  final int? level;
  final bool? isBase;
  final String? type; // [PNG,SVG.CSP]
  final List<Color>? colors;
  final String? source; // [NWT, AST, FILE, RAW, MMRY]
  PathItemModel(
      {this.asset,
      this.dx,
      this.dy,
      this.dz,
      this.height,
      this.width,
      this.page,
      this.level,
      this.isBase,
      this.source,
      this.type,
      this.colors});
}

enum AssetType { png, svg, csp }
enum AssetSource { nwt, ast, file, raw, mmry }

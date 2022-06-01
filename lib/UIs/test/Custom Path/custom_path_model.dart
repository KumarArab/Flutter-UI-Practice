import 'dart:ffi';

import 'package:flutter/cupertino.dart';

enum PathType { cubic, quadratic, linear, arc, rect, move }

class CustomPathModel {
  final PathType pathType;
  int mlIndex;
  final List<double> cords;
  final int page;

  CustomPathModel({
    required this.pathType,
    required this.cords,
    required this.mlIndex,
    required this.page,
  });
}

class MilestoneModel {
  final String? asset;
  final double? dx, dy;
  final double? width, height;
  final List<Reward>? rewards;
  final String? description;
  final String? route;
  final String? assetType;
  final String? animType;
  final bool? isCompleted;
  final int? page;
  final bool? aligment; //Left || Right
  MilestoneModel({
    this.asset,
    this.height,
    this.width,
    this.dx,
    this.dy,
    this.rewards,
    this.description,
    this.route,
    this.animType,
    this.assetType,
    this.page,
    this.aligment,
    this.isCompleted = false,
  });
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
  final String? alignment; //Left || Right
  final String? source; // [NWT, AST, FILE, RAW, MMRY]
  PathItemModel({
    this.asset,
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
    this.alignment,
    this.colors,
  });
}

enum AssetType { png, svg, csp }

enum AssetSource { nwt, ast, file, raw, mmry }

enum Mlastype { svg, png, lottie, rive }

enum Mlanimtype { rotate, scale, bounce, translate }

class Reward {
  final String? type;
  final int? amount;

  Reward({this.amount, this.type});
}

import 'package:flutter/material.dart';

import 'custom_overlay.dart';

class CustomMaterialPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  CustomMaterialPageRoute({
    required this.builder,
    required RouteSettings settings,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor = Colors.blue,
    this.barrierLabel = "label",
    this.maintainState = true,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  @override
  final Duration transitionDuration;
  @override
  final bool opaque;
  @override
  final bool barrierDismissible;
  @override
  final Color barrierColor;
  @override
  final String barrierLabel;
  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return CustomMaterialPageOverlay(
      builder: builder,
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    throw UnimplementedError();
  }
}

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class ActiveFloatingMilestone extends StatefulWidget {
  final String? png, svg;
  final double? dx, dy;
  const ActiveFloatingMilestone({this.dx, this.dy, this.png, this.svg});
  @override
  _ActiveFloatingMilestoneState createState() =>
      _ActiveFloatingMilestoneState();
}

class _ActiveFloatingMilestoneState extends State<ActiveFloatingMilestone>
    with SingleTickerProviderStateMixin {
  AnimationController? _floatAnimationController;
  Animation<Offset>? _floatAnimation;
  @override
  void initState() {
    _floatAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _floatAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -0.2))
        .animate(_floatAnimationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _floatAnimationController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _floatAnimationController!.forward();
        }
      });
    _floatAnimationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _floatAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: widget.dy,
      left: widget.dx,
      child: SlideTransition(
        position: _floatAnimation!,
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 2),
                content: Text("You Tapped a milestone"),
              ),
            );
          },
          child: Image.asset(widget.png!),
        ),
      ),
    );
  }
}

class ActiveRotatingMilestone extends StatefulWidget {
  final String? png, svg;
  final double? dx, dy;
  const ActiveRotatingMilestone({this.dx, this.dy, this.png, this.svg});
  @override
  _ActiveRotatingMilestoneState createState() =>
      _ActiveRotatingMilestoneState();
}

class _ActiveRotatingMilestoneState extends State<ActiveRotatingMilestone>
    with SingleTickerProviderStateMixin {
  AnimationController? _floatAnimationController;
  // Animation<Offset>? _floatAnimation;
  @override
  void initState() {
    _floatAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _floatAnimationController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _floatAnimationController!.forward();
        }
      })
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    _floatAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: widget.dy,
      left: widget.dx,
      child: RotationTransition(
        turns: _floatAnimationController!,
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 2),
                content: Text("You Tapped first milestone"),
              ),
            );
          },
          child: Image.asset(widget.png!),
        ),
      ),
    );
  }
}

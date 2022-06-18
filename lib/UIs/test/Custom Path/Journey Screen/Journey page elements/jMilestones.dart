import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_data.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_logic.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:testapp/utils/size_config.dart';

class Milestones extends StatelessWidget {
  const Milestones({Key? key}) : super(key: key);
  getMilestoneType(MilestoneModel milestone) {
    switch (milestone.animType) {
      case "ROTATE":
        return ActiveRotatingMilestone(milestone: milestone);
      case "FLOAT":
        return ActiveFloatingMilestone(milestone: milestone);
      default:
        return StaticMilestone(milestone: milestone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        JourneyPageLogic.currentMilestoneList.length,
        (i) => getMilestoneType(
          JourneyPageLogic.currentMilestoneList[i],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------//
//----------------------------ANIMATED MILESTONES------------------------//
//-----------------------------------------------------------------------//

class ActiveFloatingMilestone extends StatefulWidget {
  final MilestoneModel milestone;
  const ActiveFloatingMilestone({Key? key, required this.milestone})
      : super(key: key);
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

    _floatAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -0.2))
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
      left: JourneyPageLogic.pageWidth! * widget.milestone.dx!,
      bottom: JourneyPageLogic.pageHeight! * widget.milestone.dy!,
      child: SlideTransition(
        position: _floatAnimation!,
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(widget.milestone.description!),
              ),
            );
          },
          child: Image.asset(
            widget.milestone.asset!,
            width: JourneyPageLogic.pageWidth! * widget.milestone.width!,
            height: JourneyPageLogic.pageHeight! * widget.milestone.height!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ActiveRotatingMilestone extends StatefulWidget {
  final MilestoneModel milestone;
  const ActiveRotatingMilestone({Key? key, required this.milestone})
      : super(key: key);
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
      left: JourneyPageLogic.pageWidth! * widget.milestone.dx!,
      bottom: JourneyPageLogic.pageHeight! * widget.milestone.dy!,
      child: RotationTransition(
        turns: _floatAnimationController!,
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(widget.milestone.description!),
              ),
            );
          },
          child: Image.asset(
            widget.milestone.asset!,
            width: JourneyPageLogic.pageWidth! * widget.milestone.width!,
            height: JourneyPageLogic.pageHeight! * widget.milestone.height!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class StaticMilestone extends StatelessWidget {
  final MilestoneModel milestone;
  const StaticMilestone({Key? key, required this.milestone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: JourneyPageLogic.pageWidth! * milestone.dx!,
      bottom: JourneyPageLogic.pageHeight! * milestone.dy!,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(milestone.description!)));
        },
        child: Tooltip(
          message: milestone.description,
          triggerMode: TooltipTriggerMode.longPress,
          child: Image.asset(
            milestone.asset!,
            width: JourneyPageLogic.pageWidth! * milestone.width!,
            height: JourneyPageLogic.pageHeight! * milestone.height!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

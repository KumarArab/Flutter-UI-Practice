import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/data_backup_cloud_page.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/data_backup_completed_page.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/data_backup_initial_page.dart';

const mainDataBackupColor = Color(0xff24A19C);
const secondaryDataBackkupColor = Color(0xff96CEB4);
const backgroundColor = Color(0xffFAEEE7);

class DataBackupHome extends StatefulWidget {
  const DataBackupHome({Key? key}) : super(key: key);

  @override
  State<DataBackupHome> createState() => _DataBackupHomeState();
}

class _DataBackupHomeState extends State<DataBackupHome>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _progressAnimation;
  Animation<double>? _cloudOutAnimation;
  Animation<double>? _endingAnimation;
  Animation<double>? _bubbleAnimation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));
    _progressAnimation = CurvedAnimation(
        parent: _animationController!, curve: const Interval(0.0, 0.65));
    _cloudOutAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(0.7, 0.85, curve: Curves.easeOut),
    );
    _bubbleAnimation = CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.0, 1.0, curve: Curves.decelerate));

    _endingAnimation = CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.8, 1.0, curve: Curves.decelerate));

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          DataBackupInitialPage(
            progressAnimation: _progressAnimation,
            onAnimationStarted: () {
              _animationController!.forward();
            },
          ),
          DataBackupCloudPage(
              progressAnimation: _progressAnimation,
              cloudOutAnimation: _cloudOutAnimation,
              bubbleAnimation: _bubbleAnimation),
          DataBackupCompletedPage(endingAnimation: _endingAnimation)
        ],
      ),
    );
  }
}

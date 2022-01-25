import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/bubble_backup_animation.dart';
import 'package:testapp/utils/size_config.dart';

const _duration = Duration(milliseconds: 500);
enum DataBackupState {
  initial,
  start,
  end,
}

class DataBackupInitialPage extends StatefulWidget {
  const DataBackupInitialPage({
    Key? key,
    this.onAnimationStarted,
    this.progressAnimation,
  }) : super(key: key);

  final VoidCallback? onAnimationStarted;
  final Animation<double>? progressAnimation;

  @override
  State<DataBackupInitialPage> createState() => _DataBackupInitialPageState();
}

class _DataBackupInitialPageState extends State<DataBackupInitialPage> {
  DataBackupState _currentState = DataBackupState.initial;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              flex: 3,
              child: Text(
                "Cloud Storage",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            if (_currentState == DataBackupState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder(
                  duration: _duration,
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (_, double value, child) {
                    return Opacity(opacity: value, child: child);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "uploading files",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ProgressCounter(
                              animation: widget.progressAnimation,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_currentState != DataBackupState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder(
                  duration: _duration,
                  onEnd: () {
                    setState(() {
                      _currentState = DataBackupState.end;
                    });
                  },
                  tween: Tween(
                      begin: 1.0,
                      end:
                          _currentState != DataBackupState.initial ? 0.0 : 1.0),
                  builder: (_, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                          offset: Offset(0.0, -50 * value), child: child),
                    );
                  },
                  child: Column(
                    children: const [
                      Text("Last Backup:"),
                      SizedBox(height: 10),
                      Text(
                        "28 Dec 2021",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AnimatedSwitcher(
                duration: _duration,
                child: _currentState == DataBackupState.initial
                    ? SizedBox(
                        width: SizeConfig.width,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _currentState = DataBackupState.start;
                            });
                            widget.onAnimationStarted!();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              primary: mainDataBackupColor),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Create Backup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: mainDataBackupColor),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  ProgressCounter({Key? key, this.animation})
      : super(key: key, listenable: animation!);
  double get value => (listenable as Animation).value;
  final Animation<double>? animation;
  @override
  Widget build(BuildContext context) {
    return Text("${(value * 100).truncate()}%");
  }
}

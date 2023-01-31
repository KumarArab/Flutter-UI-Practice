import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation =
        CurvedAnimation(parent: _controller!, curve: const Interval(0, 1));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Count the Rebuilds"),
        actions: [
          TextButton(
              onPressed: () {
                _controller!.forward();
              },
              child: const Text("Animate"))
        ],
      ),
      body: AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) => Transform.rotate(
          angle: _controller!.value,
          child: ListView.builder(
            itemCount: 10000,
            itemBuilder: (ctx, i) => ListTile(
              title: Text('Title $i'),
              subtitle: Text("Subtitle $i"),
              leading: CircleAvatar(
                child: Text(i.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

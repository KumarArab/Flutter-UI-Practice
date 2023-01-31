import 'dart:async';

import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  Stream<int> futureTask() async* {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 1), () {
        debugPrint("I'm a future function executed $i times");
      });
      yield i;
    }
  }

  Stream<int> numbers() =>
      Stream.periodic(const Duration(seconds: 1), (timer) => timer + 1)
          .take(10);

  var res;
  @override
  initState() {
    super.initState();
    res = futureTask();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Main build called");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              debugPrint("FAB tapped");
            });
          }),
      body: Center(
        child: StreamBuilder(
          stream: futureTask(),
          builder: (ctx, snapshot) {
            debugPrint("Building FB");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                return Text("Data is ${snapshot.data}");
              case ConnectionState.done:
                return Text("Done at ${snapshot.data}");
            }
          },
        ),
      ),
    );
  }
}


//Solution 
// initialize futureBuilder/Streambuilder method in init method and pass a referrence to the builder


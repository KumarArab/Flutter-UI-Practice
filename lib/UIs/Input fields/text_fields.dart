import 'dart:developer';

import 'package:flutter/material.dart';

class Textfields extends StatelessWidget {
  Textfields({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  int i = 1;
  @override
  Widget build(BuildContext context) {
    log("Build Triggered $i time");
    return Scaffold(
        appBar: AppBar(
          title: const Text("TextFields"),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/test_widgets/draggable_container_top.dart';

class TestView extends StatelessWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Widgets"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
            title: const Text("Draggable container from top"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TestPage(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

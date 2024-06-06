import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/airbnb/home_view.dart';
import 'package:testapp/main.dart';

class NestedNavCheckHome extends StatelessWidget {
  const NestedNavCheckHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: TestHome(),
    );
  }
}

class TestHome extends StatelessWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => AirBnbHomeView()));
            },
            child: Text("Hitme")),
      ),
    );
  }
}

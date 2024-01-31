// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'custom_bottom_sheet/cb_sheet.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<String> _items = <String>["Item 1", "Item 2", "Item 3"];

  void _addItem() {
    setState(() {
      int index = _items.length;
      _items.add('Item ${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test screen"),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];

          return ListTile(
            tileColor: Color((Random(index).nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
            title: Text(item),
            onTap: () {
              Navigator.push(context, _createRoute());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem();
          // MaterialPageRoute(builder: builder)
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      barrierColor: Colors.transparent,
      pageBuilder: (context, animation, secondaryAnimation) {
        return CBBottomSheet(
          0.4,
          backGroundScreen: Container(),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

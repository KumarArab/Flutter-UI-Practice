import 'package:flutter/material.dart';
import 'package:testapp/UIs/crossSell/custom_bottom_sheet/ellipse/ellipse_widget.dart';
import 'package:testapp/UIs/crossSell/test_screen.dart';

/// Flutter code sample for [PageView].

void main() => runApp(const PageViewExampleApp());

class PageViewExampleApp extends StatelessWidget {
  const PageViewExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
        child: Scaffold(
          // body: CBSheetScreen(),
          body: TestScreen(),
          // body: Center(
          //   child: EllipseWidget(),
          // ),
        ),
      ),
    );
  }
}

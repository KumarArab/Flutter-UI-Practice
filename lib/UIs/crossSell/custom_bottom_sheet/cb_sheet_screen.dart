import 'package:flutter/material.dart';
import 'package:testapp/UIs/crossSell/custom_bottom_sheet/cb_sheet.dart';
import 'package:testapp/UIs/crossSell/test_screen.dart';

class CBSheetScreen extends StatefulWidget {
  const CBSheetScreen({Key? key}) : super(key: key);

  @override
  State<CBSheetScreen> createState() => _CBSheetScreenState();
}

class _CBSheetScreenState extends State<CBSheetScreen> {
  Widget get _flow {
    return const CBBottomSheet(
      1 - 1 / GOLDEN_RATIO,
      backGroundScreen: TestScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _flow,
        ],
      ),
    );
  }
}

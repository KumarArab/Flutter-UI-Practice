// InstaProfilePage
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class InstaProfilePage extends StatefulWidget {
  const InstaProfilePage({Key? key}) : super(key: key);

  @override
  _InstaProfilePageState createState() => _InstaProfilePageState();
}

class _InstaProfilePageState extends State<InstaProfilePage> {
  double get randHeight => Random().nextInt(100).toDouble();

  List<Widget>? _randomChildren;
  ScrollController? scrollController;
  // Children with random heights - You can build your widgets of unknown heights here
  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(3, (index) {
      final height = randHeight.clamp(
        50.0,
        MediaQuery.of(context)
            .size
            .width, // simply using MediaQuery to demonstrate usage of context
      );
      return Container(
        color: Colors.primaries[index],
        height: height,
        child: Text('Random Height Child ${index + 1}'),
      );
    });

    return _randomChildren!;
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController!.addListener(() {
      print(scrollController!.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: SizeConfig.height,
        child: Column(
          children: [
            Container(
              height: SizeConfig.height! * 0.3,
              color: Colors.red,
            ),
            Row(
              children: [
                Container(
                  height: 80,
                  width: SizeConfig.width! * 0.5,
                  color: Colors.blue,
                ),
                Container(
                  height: 80,
                  width: SizeConfig.width! * 0.5,
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
      ),
    )
        // DefaultTabController(
        //   length: 2,
        //   child: NestedScrollView(
        //     physics: const ClampingScrollPhysics(),
        //     controller: scrollController,
        //     // allows you to build a list of elements that would be scrolled away till the body reached the top
        //     headerSliverBuilder: (context, _) {
        //       return [
        //         SliverList(
        //           delegate: SliverChildListDelegate(
        //             _randomHeightWidgets(context),
        //           ),
        //         ),
        //       ];
        //     },
        //     // You tab view goes here
        //     body: Column(
        //       children: <Widget>[
        //         TabBar(
        //           tabs: [
        //             Tab(text: 'A'),
        //             Tab(text: 'B'),
        //           ],
        //         ),
        //         Expanded(
        //           child: TabBarView(
        //             children: [
        //               GridView.count(
        //                 physics: NeverScrollableScrollPhysics(),
        //                 padding: EdgeInsets.zero,
        //                 shrinkWrap: true,
        //                 crossAxisCount: 3,
        //                 children: Colors.primaries.map((color) {
        //                   return Container(color: color, height: 150.0);
        //                 }).toList(),
        //               ),
        //               ListView(
        //                 physics: NeverScrollableScrollPhysics(),
        //                 shrinkWrap: true,
        //                 padding: EdgeInsets.zero,
        //                 children: Colors.primaries.map((color) {
        //                   return Container(color: color, height: 150.0);
        //                 }).toList(),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';

class InfiniteScrollBG extends StatelessWidget {
  const InfiniteScrollBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: List.generate(
            100,
            (index) => Image.asset(
              "assets/images/bg.png",
              width: SizeConfig.width,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:testapp/utils/size_config.dart';

class MultiScratchView extends StatelessWidget {
  const MultiScratchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isScrollable = true;

  bool get isScrollable => _isScrollable;

  set isScrollable(bool value) {
    setState(() {
      _isScrollable = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.width * 0.8,
            width: size.width,
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: [
                Scratcher(
                  onScratchStart: () {
                    isScrollable = false;
                  },
                  onScratchEnd: () {
                    isScrollable = true;
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: size.width * 0.8,
                      width: SizeConfig.width! * 0.8,
                      color: Colors.amber),
                ),
                Scratcher(
                  onScratchStart: () {
                    isScrollable = false;
                  },
                  onScratchEnd: () {
                    isScrollable = true;
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: size.width * 0.8,
                      width: SizeConfig.width! * 0.8,
                      color: Colors.amber),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Zapp!');
        },
        backgroundColor: Colors.yellow[700],
        child: const Icon(
          Icons.bolt,
          color: Colors.black,
        ),
      ),
    );
  }
}

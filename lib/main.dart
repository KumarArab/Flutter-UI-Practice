import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/bubble_backup_animation.dart';
import 'package:testapp/UIs/Staggered%20Grid%20View/staggered_grid_view.dart';
import 'package:testapp/UIs/adaptive_test.dart';
import 'package:testapp/UIs/circular_ring_animation/baseAnimation.dart';
import 'package:testapp/UIs/circular_ring_animation/circular_anim_main.dart';
import 'package:testapp/UIs/compass/compass_screen.dart';
import 'package:testapp/UIs/custom_paint/paint.dart';
import 'package:testapp/UIs/image-animation/image_anim_main.dart';
import 'package:testapp/UIs/multi_scratch_card_view/instant_scratch_view.dart';
import 'package:testapp/UIs/path_glow/path_glow_main.dart';
import 'package:testapp/UIs/test/test.dart';
import 'package:testapp/apps/installed_apps.dart';
import 'package:testapp/utils/size_config.dart';

void main() async {
  // debugPrintGestureArenaDiagnostics = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // DevicePreview(
        //   enabled: true,
        //   builder: (ctx) =>
        MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      // showPerformanceOverlay: true,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
      // ),
    );
  }
}

// ignore: camel_case_types
typedef uItems = Map<String, Widget>;

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<uItems> items = [
    {
      "Staggered Grid View": const StaggeredGridView(),
    },
    {
      "Bubble Animation": const DataBackupHome(),
    },
    {
      "Image Animation": const FooSpritePaint(),
    },
    {
      "Test View": const TestView(),
    },
    {
      "Flutter Paint": FlutterPaint(),
    },
    {
      "Base Glow": const PathGlowMain(),
    },
    {
      "Circular Animation": const CircularAnim(),
    },
    {
      "Circular Animation 2": const BaseAnimation(),
    },
    {
      "Multi scratch cards": const MultiScratchView(),
    },
    {
      "Widget Rebuild": MyWidget(),
    },
    {
      "Compass": const CompassScreen(),
    },
    {
      "Installed Apps": const InstalledApps(),
    }
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "increment",
        child: const Icon(Icons.abc),
        onPressed: () {
          print("Hello world!");
        },
      ),
      appBar: AppBar(
        key: const Key("AppBar"),
        title: const Text("Flutter UIs"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, i) => ListTile(
            key: Key("key$i"),
            leading: const Icon(
              Icons.grid_3x3,
              color: Colors.teal,
            ),
            title: Text(items[i].keys.first),
            onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (ctx) => items[i].values.first,
                  ),
                )),
      ),
    );
  }
}

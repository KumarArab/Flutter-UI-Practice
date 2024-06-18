import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/bubble_backup_animation.dart';
import 'package:testapp/UIs/Staggered%20Grid%20View/staggered_grid_view.dart';
import 'package:testapp/UIs/adaptive_test.dart';
import 'package:testapp/UIs/airbnb/home_view.dart';
import 'package:testapp/UIs/animated_timeline/animated_timeline.dart';
import 'package:testapp/UIs/boomerang_swiper/pages/home_page.dart';
import 'package:testapp/UIs/cards/cards_home.dart';
import 'package:testapp/UIs/charts/line_grad_chart.dart';
import 'package:testapp/UIs/circular_ring_animation/baseAnimation.dart';
import 'package:testapp/UIs/circular_ring_animation/circular_anim_main.dart';
import 'package:testapp/UIs/compass/compass_screen.dart';
import 'package:testapp/UIs/crossSell/main3.dart';
import 'package:testapp/UIs/crossSell/test_screen.dart';
import 'package:testapp/UIs/crossSellV2/cross_sell_main.dart';
import 'package:testapp/UIs/custom_paint/paint.dart';
import 'package:testapp/UIs/image-animation/image_anim_main.dart';
import 'package:testapp/UIs/lotties/lottie.dart';
import 'package:testapp/UIs/multi_scratch_card_view/instant_scratch_view.dart';
import 'package:testapp/UIs/nested_nav/nested_nav_home.dart';
import 'package:testapp/UIs/path_glow/path_glow_main.dart';
import 'package:testapp/UIs/slivers/insta_nested_scroll_view.dart';
import 'package:testapp/UIs/test/test.dart';
import 'package:testapp/apps/installed_apps.dart';
import 'package:testapp/gists/circular_slider/circular_slider.dart';
import 'package:testapp/gists/page_view_sample.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:testapp/gists/wave_slider.dart.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
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
      key: navKey,
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
      "Animated Timeline":  Timeline()
    },
    {
      "Wave Slider": const WaveSlider(color: Colors.teal),
    },
    {"Nested nav": const NestedNavCheckHome()},
    {
      "AirBnb Anim": const AirBnbHomeView(),
    },
    {
      "Circular Slider": const MyCircularSlider(),
    },
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
    },
    {
      "Cool Cards": const Cards(),
    },
    {
      "Lottie Fun": const LottieTest(),
    },
    {
      "Line Gradient Chart": const LineGradientChart(),
    },
    {
      "Insta Nested ScrollView": const InstaProfilePage(),
    },
    {
      "Cool Boomerang Swiper": const CoolSwiperHomePage(),
    },
    {
      "Cross Sell": const TestScreen(),
    },
    {
      "Parallax Recipie": const ParallaxRecipe(),
    },
    {
      "Cross Sell V2": const UpSellMain(),
    },
    {
      "Page View": const PageViewSample(),
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

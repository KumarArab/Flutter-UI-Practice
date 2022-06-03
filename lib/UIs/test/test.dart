import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_view.dart';
import 'package:testapp/UIs/test/other_tests/infinite_scroll_bg.dart';
import 'package:testapp/UIs/test/other_tests/rotating_loader.dart';
import 'package:testapp/UIs/test/stack_overflow/slider_swiper.dart';
import 'package:testapp/UIs/test/test_widgets/draggable_container_top.dart';
import 'package:testapp/UIs/test/time_machine.dart';

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
          ),
          ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
            title: const Text("Custom Path"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const JourneyScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
            title: const Text("Infinite Scroll Path"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const InfiniteScrollBG(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
            title: const Text("Slider Swiper"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const SliderSwiper(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
            title: const Text("Rotating Loader"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ArcWidget(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.orange,
            ),
            title: const Text("Time machine"),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TimeMachine(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

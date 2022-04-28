import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path.dart';
import 'package:testapp/UIs/test/Custom%20Path/infinite_scroll_bg.dart';
import 'package:testapp/UIs/test/Custom%20Path/rotating_loader.dart';
import 'package:testapp/UIs/test/Custom%20Path/vertical_path.dart';
import 'package:testapp/UIs/test/stack_overflow/slider_swiper.dart';
import 'package:testapp/UIs/test/test_widgets/draggable_container_top.dart';

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
                builder: (ctx) => const CustomPath(),
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
          //  ListTile(
          //   leading: const Icon(
          //     Icons.circle,
          //     color: Colors.orange,
          //   ),
          //   title: const Text("Flutter Tree"),
          //   onTap: () => Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (ctx) => const Demo(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

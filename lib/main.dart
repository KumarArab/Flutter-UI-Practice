import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/Bubble%20Backup%20Animation/bubble_backup_animation.dart';
import 'package:testapp/UIs/Staggered%20Grid%20View/staggered_grid_view.dart';
import 'package:testapp/UIs/image-animation/image_anim_main.dart';
import 'package:testapp/UIs/test/test.dart';
import 'package:testapp/utils/size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter UIs"),
      ),
      body: ListView.builder(
        itemCount: 4,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, i) => ListTile(
            leading: const Icon(
              Icons.grid_3x3,
              color: Colors.teal,
            ),
            title: Text(name(i)),
            onTap: () => enter(i, context)),
      ),
    );
  }

  name(int index) {
    switch (index) {
      case 0:
        return "Staggered Grid View";
      case 1:
        return "Bubble Animation";
      case 2:
        return "Image Animation";

      case 3:
        return "Test View";

      default:
        return "Not yet decided";
    }
  }

  enter(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => const StaggeredGridView(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => const DataBackupHome(),
          ),
        );

        break;
      case 2:
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => const FooSpritePaint(),
          ),
        );

        break;
      case 3:
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => const TestView(),
          ),
        );

        break;
      default:
        break;
    }
  }
}

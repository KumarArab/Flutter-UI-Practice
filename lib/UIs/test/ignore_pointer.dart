import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:testapp/utils/size_config.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class InfinteList extends StatefulWidget {
  const InfinteList({Key? key}) : super(key: key);

  @override
  State<InfinteList> createState() => _InfinteListState();
}

class _InfinteListState extends State<InfinteList> {
  ScrollController? controller;
  bool showMaxExtentIcon = false;
  @override
  void initState() {
    controller = ScrollController();
    // controller!.addListener(() {
    //   log(controller!.offset.toString());
    //   if (showMaxExtentIcon && mounted) {
    //     setState(() {
    //       showMaxExtentIcon = false;
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text("Ignore Pointer Example")),
      body: Stack(children: [
        SizedBox(
          height: SizeConfig.height,
          width: SizeConfig.width,
          child: ListView.builder(
            controller: controller,
            itemBuilder: (ctx, i) {
              return ListTile(
                  tileColor: Colors.grey.withOpacity(0.1),
                  leading: CircleAvatar(
                    backgroundColor:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                    child: Text(
                      "${i + 1}",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  title: Text("Title ${i + 1}"),
                  subtitle: Text("This is Subtitle ${i + 1}"),
                  trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          showMaxExtentIcon = true;
                        });
                      },
                      icon: const Icon(
                        Icons.navigate_next,
                        color: Colors.grey,
                      )));
            },
            itemCount: 80,
          ),
        ),
        if (showMaxExtentIcon)
          Align(
              alignment: Alignment.center,
              child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                      width: SizeConfig.width! - SizeConfig.width! * 0.08,
                      margin: EdgeInsets.all(SizeConfig.width! * 0.04),
                      height: SizeConfig.height! / 2.4,
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/lotties/check.json"))))
      ]),
    );
  }
}

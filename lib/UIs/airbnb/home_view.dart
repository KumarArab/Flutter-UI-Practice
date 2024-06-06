import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:testapp/UIs/airbnb/modalsheet_view.dart';

class AirBnbHomeView extends StatefulWidget {
  const AirBnbHomeView({Key? key}) : super(key: key);

  @override
  State<AirBnbHomeView> createState() => _AirBnbHomeViewState();
}

class _AirBnbHomeViewState extends State<AirBnbHomeView> {
  List<Color> colors = [Colors.teal, Colors.amber, Colors.purple, Colors.brown, Colors.red];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(),
        body: SafeArea(
          bottom: false,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: colors.length,
            itemBuilder: (ctx, i) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 250,
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: colors[i]),
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => AirBnbModalSheetView(
                      heroId: "card$i",
                    ),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ));
                },
                child: AvatarCard(
                  heroId: "card$i",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarCard extends StatefulWidget {
  const AvatarCard({Key? key, required this.heroId}) : super(key: key);

  final String heroId;

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _isOpen = false;

  get isOpen => _isOpen;
  set isOpen(val) {
    setState(() {
      _isOpen = val;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: widget.heroId,
          child: Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
              ),

              // Transform(
              //   transform: Matrix4.identity()..rotateY(pi  * _animationController.value),
              //   child: Container(
              //     height: 80,
              //     width: 80,
              //     decoration: BoxDecoration(
              //       color: Colors.blue,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(1, 2, 1)
                  ..rotateY(pi * _animationController.value),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: 10,
                  height: 80,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Switch.adaptive(
          value: _isOpen,
          onChanged: (val) {
            isOpen = val;
            if (val) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
        )
      ],
    );
  }
}

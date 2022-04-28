import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:testapp/utils/size_config.dart';

class SliderSwiper extends StatefulWidget {
  const SliderSwiper({Key? key}) : super(key: key);

  @override
  State<SliderSwiper> createState() => _SliderSwiperPageState();
}

class _SliderSwiperPageState extends State<SliderSwiper> {
  final AppinioSwiperController controller = AppinioSwiperController();

  List<ExampleCard> images = [];
  List<String> text = [
    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1650972917~exp=1650973517~hmac=74a1e02177f2ce5823c85bd5ff1cca0b41115ae74961282162428d62fa1fb2f2&w=1800',
    'https://img.freepik.com/free-photo/close-up-young-handsome-man-isolated_273609-36336.jpg?w=1800',
    'https://img.freepik.com/free-photo/indoor-shot-indignant-puzzled-curly-haired-afro-american-woman-shugs-shoulder-has-hesitant-expression-wears-spectacles-casual-turtleneck-isolated-white-background-so-what-did-you-say_273609-54635.jpg?w=1800',
    'https://img.freepik.com/free-photo/portrait-woman-with-grapes-her-head_23-2149384038.jpg?t=st=1650972917~exp=1650973517~hmac=531941d886d8bee5e44363727b5f024f747ce9530ebec20919cbd0540cc00643&w=740',
    'https://img.freepik.com/free-photo/portrait-happy-smiley-man_23-2149022628.jpg?w=1800',
    'https://img.freepik.com/free-photo/senior-person-gesturing-isolated_23-2149193771.jpg?w=1800',
    'https://img.freepik.com/free-photo/portrait-man-holding-kiwi-fruit_23-2149384050.jpg?t=st=1650972917~exp=1650973517~hmac=8a1eb2b095b0d7a496682a407fb491d7a40106353581bee344e5a5cdf604db41&w=740',
    'https://img.freepik.com/free-photo/man-wearing-t-shirt-gesturing_23-2149393639.jpg?w=1800',
    'https://img.freepik.com/free-photo/handsome-man-posing_23-2149396094.jpg?w=1800',
    'https://img.freepik.com/free-photo/beautiful-asian-woman-posing-with-perfect-skin_23-2149369921.jpg?w=1800',
  ];

  @override
  void initState() {
    _loadCards();
    super.initState();
    controller.addListener(() {
      log(controller.toString());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFE9EFF2),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: AppinioSwiper(
              controller: controller,
              cards: images,
              onSwipe: _swipe,
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
                bottom: 40,
              ),
            ),
          ),
          CupertinoButton(
            child: const Text("unswipe"),
            color: const Color(0xFF053149),
            onPressed: () => controller.unswipe(),
          ),
          Container(
              height: SizeConfig.height! * 0.1,
              child: CupertinoSlider(value: 0.5, onChanged: (val) {}))
        ],
      ),
    );
  }

  void _swipe(int index) {
    print("swipe");
  }

  void _loadCards() {
    for (String text in text) {
      images.add(ExampleCard(image: text));
    }
  }
}

class ExampleCard extends StatelessWidget {
  final String image;

  const ExampleCard({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CupertinoColors.white,
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Do you like the picture?",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 300,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF053149),
                  ),
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 20,
                      color: CupertinoColors.white,
                    ),
                  ),
                  height: 50,
                  width: 300,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF053149),
                  ),
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontSize: 20,
                      color: CupertinoColors.white,
                    ),
                  ),
                  height: 50,
                  width: 300,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

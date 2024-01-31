import 'package:flutter/material.dart';

import 'package:testapp/UIs/boomerang_swiper/data.dart';
import 'package:testapp/UIs/boomerang_swiper/src/widgets/cool_swiper.dart';
import 'package:testapp/UIs/boomerang_swiper/widgets/card_content.dart';

class CoolSwiperHomePage extends StatelessWidget {
  const CoolSwiperHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CoolSwiper(
            children: List.generate(
              Data.colors.length,
              (index) => CardContent(color: Data.colors[index]),
            ),
          ),
        ),
      ),
    );
  }
}

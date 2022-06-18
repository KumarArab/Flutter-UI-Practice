import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_view.dart';
import 'package:testapp/utils/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/utils/slide_in_from_bottom.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: SizeConfig.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lotties/loader.json",
              height: SizeConfig.width! * 0.6),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                EnterExitRoute(
                  exitPage: this,
                  enterPage: const JourneyScreen(),
                ),
              );
            },
            child: Text(
              "Loading, please wait",
              style: GoogleFonts.josefinSans(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          )
        ],
      ),
    ));
  }
}

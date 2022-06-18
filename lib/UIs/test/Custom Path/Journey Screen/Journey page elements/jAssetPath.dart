import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_data.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_logic.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JourneyAssetPath extends StatelessWidget {
  const JourneyAssetPath({Key? key}) : super(key: key);

  getChild(JourneyPathModel item) {
    switch (item.type) {
      case "SVG":
        return item.source == "NTWRK"
            ? SvgPicture.network(
                item.asset!,
                height: item.height,
                width: item.width,
              )
            : SvgPicture.asset(
                item.asset!,
                width: JourneyPageLogic.pageWidth! * item.width!,
                height: JourneyPageLogic.pageHeight! * item.height!,
              );
      case "PNG":
        return item.source == "NTWRK"
            ? Image.network(
                item.asset!,
                height: item.height,
                width: item.width,
              )
            : Image.asset(
                item.asset!,
                width: JourneyPageLogic.pageWidth! * item.width!,
                height: JourneyPageLogic.pageHeight! * item.height!,
              );
    }
  }

  @override
  Widget build(BuildContext context) {
    JourneyPageLogic.journeyPathItemsList
        .sort((a, b) => a.dz!.compareTo(b.dz!));
    return Stack(
      children: List.generate(
        JourneyPageLogic.journeyPathItemsList.length,
        (i) => Positioned(
          left: JourneyPageLogic.pageWidth! *
              JourneyPageLogic.journeyPathItemsList[i].dx!,
          bottom: JourneyPageLogic.pageHeight! *
              JourneyPageLogic.journeyPathItemsList[i].dy!,
          child: Container(
            width: JourneyPageLogic.pageWidth! *
                JourneyPageLogic.journeyPathItemsList[i].width!,
            height: JourneyPageLogic.pageHeight! *
                JourneyPageLogic.journeyPathItemsList[i].height!,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            //         .withOpacity(1.0),
            //     width: 1,
            //   ),
            //   // borderRadius: BorderRadius.circular(10),
            // ),
            alignment: Alignment.bottomCenter,
            child: getChild(JourneyPageLogic.journeyPathItemsList[i]),
          ),
        ),
      ),
    );
  }
}

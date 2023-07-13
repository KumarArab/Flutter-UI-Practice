// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:testapp/UIs/cards/cards_expanded.dart';
// import 'package:testapp/utils/size_config.dart';

// class Cards extends StatefulWidget {
//   const Cards({Key? key}) : super(key: key);

//   @override
//   State<Cards> createState() => _CardsState();
// }

// class _CardsState extends State<Cards> with SingleTickerProviderStateMixin {
//   // double bgWidth = SizeConfig.width!;
//   ScrollController? controller;
//   bool isHorizontalView = false;
//   bool isVerticalView = false;
//   Duration duration = const Duration(milliseconds: 400);
//   Curve curve = Curves.decelerate;
//   // Animation<double> gradientAnimation;

//   AnimationController? gradientController;
//   @override
//   void initState() {
//     gradientController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..addListener(() {
//         setState(() {});
//       });

//     controller = ScrollController()
//       ..addListener(() {
//         if (controller!.offset <= controller!.position.minScrollExtent) {
//           print("Put cards back together");
//           if (isHorizontalView) {
//             setState(() {
//               isHorizontalView = false;
//             });
//             Future.delayed(
//               duration,
//               () {
//                 gradientController?.reset();
//                 gradientController?.forward();
//               },
//             );
//           }
//         }
//       });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     gradientController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Color(0xff262629),
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: GestureDetector(
//           onVerticalDragEnd: (details) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const CardsExpanded(),
//               ),
//             ).then((value) {
//               if (!isHorizontalView) {
//                 Future.delayed(
//                   duration,
//                   () {
//                     gradientController?.reset();
//                     gradientController?.forward();
//                   },
//                 );
//               }
//             });
//           },
//           onHorizontalDragEnd: (_) {
//             setState(() {
//               // bgWidth = SizeConfig.width! * 3;
//               isHorizontalView = true;
//               controller?.jumpTo(0);
//             });
//           },
//           child: SizedBox(
//             height: SizeConfig.width! * 0.6,
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xff262629),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(SizeConfig.titleSize!! / 2),
//                       bottomRight: Radius.circular(SizeConfig.titleSize!! / 2),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     controller: controller,
//                     physics: isHorizontalView
//                         ? const BouncingScrollPhysics()
//                         : const NeverScrollableScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     child: AnimatedContainer(
//                       curve: curve,
//                       duration: duration,
//                       padding: EdgeInsets.only(
//                           top: SizeConfig.titleSize!! / 2,
//                           left:
//                               isHorizontalView ? 0 : SizeConfig.titleSize!! / 2,
//                           right: SizeConfig.titleSize!! / 2,
//                           bottom: SizeConfig.titleSize!! / 2),
//                       height: SizeConfig.width! * 0.6,
//                       width: SizeConfig.width! * (isHorizontalView ? 2.4 : 1),
//                       child: Stack(
//                         children: [
//                           AnimatedPositioned(
//                             curve: curve,
//                             duration: duration,
//                             bottom: 0,
//                             left: isHorizontalView
//                                 ? SizeConfig.width! * 1.63
//                                 : SizeConfig.width! * 0.075 * 3,
//                             child: Hero(
//                               tag: "mainCard",
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       SizeConfig.titleSize!! / 3),
//                                 ),
//                                 margin: EdgeInsets.zero,
//                                 color: const Color(0xFF627F8E).withOpacity(0.8),
//                                 child: AnimatedContainer(
//                                   curve: curve,
//                                   duration: duration,
//                                   height: SizeConfig.width! * 0.45 -
//                                       (SizeConfig.width! *
//                                           0.64 *
//                                           0.03 *
//                                           (isHorizontalView ? 0 : 4)),
//                                   width: SizeConfig.width! * 0.8 -
//                                       (SizeConfig.width! * 0.8 * 0.04 * 4),
//                                   child: const Center(
//                                     child: Text(
//                                       'Card 3',
//                                       style: TextStyle(fontSize: 30.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           AnimatedPositioned(
//                             curve: curve,
//                             duration: duration,
//                             left: isHorizontalView
//                                 ? SizeConfig.width! * 0.88
//                                 : SizeConfig.width! * 0.078 * 2,
//                             bottom: 0,
//                             child: Hero(
//                               tag: "goldCard",
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       SizeConfig.titleSize!! / 3),
//                                 ),
//                                 margin: EdgeInsets.zero,
//                                 color: Color(0XFF02484D).withOpacity(0.8),
//                                 child: AnimatedContainer(
//                                   curve: curve,
//                                   duration: duration,
//                                   height: SizeConfig.width! * 0.45 -
//                                       (SizeConfig.width! *
//                                           0.64 *
//                                           0.03 *
//                                           (isHorizontalView ? 0 : 3)),
//                                   width: SizeConfig.width! * 0.8 -
//                                       (SizeConfig.width! * 0.8 * 0.04 * 3),
//                                   child: const Center(
//                                     child: Text(
//                                       'Card 3',
//                                       style: TextStyle(fontSize: 30.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           AnimatedPositioned(
//                             curve: curve,
//                             duration: duration,
//                             left: isHorizontalView
//                                 ? SizeConfig.width! * 0.1
//                                 : SizeConfig.width! * 0.09,
//                             bottom: 0,
//                             child: Hero(
//                               tag: "floCard",
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       SizeConfig.titleSize!! / 3),
//                                 ),
//                                 margin: EdgeInsets.zero,
//                                 color: Color(0xff39498C).withOpacity(0.8),
//                                 child: AnimatedContainer(
//                                   curve: curve,
//                                   duration: duration,
//                                   height: SizeConfig.width! * 0.45 -
//                                       (SizeConfig.width! *
//                                           0.64 *
//                                           0.03 *
//                                           (isHorizontalView ? 0 : 2)),
//                                   width: SizeConfig.width! * 0.8 -
//                                       (SizeConfig.width! * 0.8 * 0.04 * 2),
//                                   child: const Center(
//                                     child: Text(
//                                       'Card 3',
//                                       style: TextStyle(fontSize: 30.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: SizeConfig.width! *
//                       0.45, // alignment: Alignment.bottomCenter,
//                   child: Transform.translate(
//                     offset: Offset(0, SizeConfig.titleSize!! / 2),
//                     child: CircleAvatar(
//                       backgroundColor: const Color(0xff262629),
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const CardsExpanded(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(
//                           Icons.keyboard_arrow_down_rounded,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 AnimatedPositioned(
//                   curve: curve, duration: duration,
//                   left: isHorizontalView
//                       ? -SizeConfig.width! * 0.8 * 0.9
//                       : SizeConfig.titleSize!! /
//                           2, // SizeConfig.width! * 0.8 * 0.04 * 3,
//                   bottom: SizeConfig.width! * 0.05,
//                   child: Hero(
//                     tag: "rewardCard",
//                     child: Material(
//                       color: Colors.transparent,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           gradient: SweepGradient(
//                             colors: const [
//                               Colors.black,
//                               Colors.grey,
//                               Colors.black,
//                             ],
//                             startAngle: 2,
//                             transform:
//                                 GradientRotation(gradientController!.value * 6),
//                           ),
//                           borderRadius:
//                               BorderRadius.circular(SizeConfig.titleSize!! / 3),
//                         ),
//                         height: SizeConfig.width! * 0.5,
//                         width: SizeConfig.width! * 0.8 -
//                             (SizeConfig.width! * 0.8 * 0.04 * 0),
//                         padding: const EdgeInsets.all(1),
//                         child: Container(
//                           padding: EdgeInsets.all(SizeConfig.titleSize!! * 0.5),
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(
//                                 SizeConfig.titleSize!! / 3),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Fello Balance",
//                                 style: GoogleFonts.rajdhani(
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                   fontSize: SizeConfig.titleSize!! * 0.6,
//                                 ),
//                               ),
//                               Text(
//                                 "Sum of all your assets on fello",
//                                 style: GoogleFonts.sourceSans3(
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.grey,
//                                   fontSize: SizeConfig.titleSize!! * 0.4,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "₹ 1004",
//                                     style: GoogleFonts.sourceSans3(
//                                       fontWeight: FontWeight.w800,
//                                       color: Colors.white,
//                                       fontSize: SizeConfig.titleSize!! * 1.2,
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.arrow_drop_up_outlined,
//                                     color: Colors.green,
//                                     size: SizeConfig.titleSize!,
//                                   ),
//                                   Text(
//                                     "0.05%",
//                                     style: GoogleFonts.sourceSans3(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.green,
//                                       fontSize: SizeConfig.titleSize!! * 0.4,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (!isHorizontalView)
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8.0),
//                       child: Transform.rotate(
//                         angle: -20.4,
//                         child: Lottie.asset("assets/lotties/swipe.json",
//                             width: SizeConfig.titleSize!! * 2),
//                       ),
//                     ),
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/utils/size_config.dart';

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> with SingleTickerProviderStateMixin {
  // double bgWidth = SizeConfig.width!;
  ScrollController? controller;
  bool isHorizontalView = false;
  bool isVerticalView = false;
  Duration duration = const Duration(milliseconds: 400);
  Curve curve = Curves.decelerate;
  // Animation<double> gradientAnimation;

  AnimationController? gradientController;
  @override
  void initState() {
    gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          print(gradientController?.value ?? 0);
        });
      });

    controller = ScrollController()
      ..addListener(() {
        if (controller!.offset <= controller!.position.minScrollExtent) {
          print("Put cards back together");
          if (isHorizontalView) {
            setState(() {
              isHorizontalView = false;
            });
            Future.delayed(
              duration,
              () {
                gradientController?.reset();
                gradientController
                    ?.forward()
                    .then((value) => print("Animation ended"));
              },
            );
          }
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    gradientController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF39393C),
        elevation: 0,
      ),
      body: AnimatedContainer(
        duration: duration,
        curve: curve,
        height: SizeConfig.width! * (isVerticalView ? 2 : 0.8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AbsorbPointer(
                absorbing: isVerticalView,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    int sensitivity = 8;
                    if (details.delta.dy > sensitivity) {
                      //swiping in down direction
                      if (!isVerticalView && mounted) {
                        setState(() {
                          isVerticalView = true;
                          print('IsVerticalView true');
                        });
                      }
                    }
                  },
                  onHorizontalDragEnd: (_) {
                    if (isVerticalView) return;
                    setState(() {
                      isHorizontalView = true;
                      controller?.jumpTo(0);
                    });
                  },
                  child: AnimatedContainer(
                    curve: curve,
                    duration: duration,
                    width: SizeConfig.width! * (isHorizontalView ? 2.4 : 1),
                    height: SizeConfig.width! * (isVerticalView ? 2 : 0.78),
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          curve: curve,
                          duration: duration,
                          decoration: BoxDecoration(
                            color: Color(0xFF39393C),
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(SizeConfig.titleSize! / 2),
                              bottomRight:
                                  Radius.circular(SizeConfig.titleSize! / 2),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: controller,
                            physics: isHorizontalView
                                ? const BouncingScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: AnimatedContainer(
                              curve: curve,
                              duration: duration,
                              padding: isVerticalView
                                  ? EdgeInsets.symmetric(
                                      vertical:
                                          SizeConfig.pageHorizontalMargins!,
                                      horizontal:
                                          SizeConfig.pageHorizontalMargins!)
                                  : EdgeInsets.only(
                                      top: SizeConfig.titleSize! / 2,
                                      left: isHorizontalView
                                          ? 0
                                          : SizeConfig.titleSize! / 2,
                                      right: SizeConfig.titleSize! / 2,
                                      bottom: SizeConfig.titleSize! / 2),
                              height: SizeConfig.width! *
                                  (isVerticalView ? 2 : 0.78),
                              width: SizeConfig.width! *
                                  (isHorizontalView ? 2.4 : 1),
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    curve: curve,
                                    duration: duration,
                                    left: isVerticalView
                                        ? 0
                                        : isHorizontalView
                                            ? SizeConfig.width! * 1.63
                                            : SizeConfig.width! * 0.075 * 3,
                                    top: SizeConfig.width! *
                                        (isVerticalView
                                            ? 1.4
                                            : isHorizontalView
                                                ? 0.05
                                                : 0.125),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.titleSize! / 3),
                                      ),
                                      margin: EdgeInsets.zero,
                                      color: const Color(0xFF627F8E)
                                          .withOpacity(0.8),
                                      child: AnimatedContainer(
                                        curve: curve,
                                        duration: duration,
                                        height: SizeConfig.width! * 0.45 -
                                            (SizeConfig.width! *
                                                0.64 *
                                                0.03 *
                                                ((isHorizontalView ||
                                                        isVerticalView)
                                                    ? 0
                                                    : 4)),
                                        width: isVerticalView
                                            ? (SizeConfig.width! -
                                                SizeConfig
                                                        .pageHorizontalMargins! *
                                                    2)
                                            : SizeConfig.width! * 0.8 -
                                                (SizeConfig.width! *
                                                    0.8 *
                                                    0.04 *
                                                    4),
                                        child: const Center(
                                          child: Text(
                                            'Card 3',
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedPositioned(
                                    curve: curve,
                                    duration: duration,
                                    left: isVerticalView
                                        ? 0
                                        : isHorizontalView
                                            ? SizeConfig.width! * 0.88
                                            : SizeConfig.width! * 0.078 * 2,
                                    top: SizeConfig.width! *
                                        (isVerticalView
                                            ? 0.9
                                            : isHorizontalView
                                                ? 0.05
                                                : 0.105),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.titleSize! / 3),
                                      ),
                                      margin: EdgeInsets.zero,
                                      color: Color(0XFF02484D).withOpacity(0.8),
                                      child: AnimatedContainer(
                                        curve: curve,
                                        duration: duration,
                                        height: SizeConfig.width! * 0.45 -
                                            (SizeConfig.width! *
                                                0.64 *
                                                0.03 *
                                                ((isHorizontalView ||
                                                        isVerticalView)
                                                    ? 0
                                                    : 3)),
                                        width: isVerticalView
                                            ? (SizeConfig.width! -
                                                SizeConfig
                                                        .pageHorizontalMargins! *
                                                    2)
                                            : SizeConfig.width! * 0.8 -
                                                (SizeConfig.width! *
                                                    0.8 *
                                                    0.04 *
                                                    3),
                                        child: const Center(
                                          child: Text(
                                            'Card 3',
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedPositioned(
                                    curve: curve,
                                    duration: duration,
                                    left: isVerticalView
                                        ? 0
                                        : isHorizontalView
                                            ? SizeConfig.width! * 0.1
                                            : SizeConfig.width! * 0.09,
                                    top: SizeConfig.width! *
                                        (isVerticalView
                                            ? 0.4
                                            : isHorizontalView
                                                ? 0.05
                                                : 0.088),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.titleSize! / 3),
                                      ),
                                      margin: EdgeInsets.zero,
                                      color: Color(0xff39498C).withOpacity(0.8),
                                      child: AnimatedContainer(
                                        curve: curve,
                                        duration: duration,
                                        height: SizeConfig.width! * 0.45 -
                                            (SizeConfig.width! *
                                                0.64 *
                                                0.03 *
                                                ((isHorizontalView ||
                                                        isVerticalView)
                                                    ? 0
                                                    : 2)),
                                        width: isVerticalView
                                            ? (SizeConfig.width! -
                                                SizeConfig
                                                        .pageHorizontalMargins! *
                                                    2)
                                            : SizeConfig.width! * 0.8 -
                                                (SizeConfig.width! *
                                                    0.8 *
                                                    0.04 *
                                                    2),
                                        child: const Center(
                                          child: Text(
                                            'Card 3',
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          curve: curve,
                          duration: duration,
                          left: isVerticalView
                              ? 0
                              : isHorizontalView
                                  ? -SizeConfig.width! * 0.8 * 0.9
                                  : SizeConfig.titleSize! / 2,
                          top: SizeConfig.width! * (isVerticalView ? 0 : 0.05),
                          child: Material(
                            color: Colors.transparent,
                            child: AnimatedContainer(
                              curve: curve,
                              duration: duration,
                              decoration: BoxDecoration(
                                gradient: SweepGradient(
                                  colors: const [
                                    Colors.black,
                                    Colors.grey,
                                    Colors.black,
                                  ],
                                  // startAngle: 1,
                                  transform: GradientRotation(
                                      gradientController!.value * 6),
                                ),
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.titleSize! / 3),
                              ),
                              height: SizeConfig.width! *
                                  (isVerticalView ? 0.4 : 0.5),
                              width: isVerticalView
                                  ? SizeConfig.width
                                  : SizeConfig.width! * 0.8 -
                                      (SizeConfig.width! * 0.8 * 0.04 * 0),
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                padding: EdgeInsets.all(
                                    SizeConfig.pageHorizontalMargins! / 2),
                                decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.titleSize! / 3),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Fello Balance",
                                      style: GoogleFonts.rajdhani(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: SizeConfig.titleSize! * 0.6,
                                      ),
                                    ),
                                    Text(
                                      "Sum of all your assets on fello",
                                      style: GoogleFonts.sourceSans3(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: SizeConfig.titleSize! * 0.4,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ 1004",
                                          style: GoogleFonts.sourceSans3(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.titleSize! * 1.2,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_up_outlined,
                                          color: Colors.green,
                                          size: SizeConfig.titleSize!,
                                        ),
                                        Text(
                                          "0.05%",
                                          style: GoogleFonts.sourceSans3(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                            fontSize:
                                                SizeConfig.titleSize! * 0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!isHorizontalView && !isVerticalView)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeConfig.pageHorizontalMargins!! * 2,
                                  right: SizeConfig.pageHorizontalMargins!!),
                              child: SvgPicture.asset(
                                  "assets/vectors/swipeh.svg",
                                  width: SizeConfig.titleSize!),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (!isVerticalView)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: SizeConfig.pageHorizontalMargins! * 1.4),
                  child: MaterialButton(
                    minWidth: SizeConfig.width! -
                        SizeConfig.pageHorizontalMargins! * 2,
                    color: Colors.white,
                    onPressed: () {
                      gradientController?.reset();
                      gradientController
                          ?.forward()
                          .then((value) => print("Animation ended"));
                    },
                    child: Text(
                      "SAVE",
                      style: GoogleFonts.rajdhani(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, SizeConfig.titleSize! / 3),
                child: CircleAvatar(
                  backgroundColor: Color(0xFF39393C),
                  child: IconButton(
                    onPressed: () {
                      if (isVerticalView) {
                        setState(() {
                          isVerticalView = false;
                          print('IsVerticalView true');
                        });
                      } else {
                        setState(() {
                          isVerticalView = true;
                          print('IsVerticalView true');
                        });
                        Future.delayed(duration, () {
                          gradientController?.reset();
                          gradientController?.forward();
                        });
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const CardsExpanded(),
                      //   ),
                      // );
                    },
                    icon: Icon(
                      isVerticalView
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

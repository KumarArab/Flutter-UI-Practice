import 'package:flutter/material.dart';
import 'package:testapp/UIs/test/Custom%20Path/Journey%20Screen/journey_page_data.dart';
import 'package:testapp/UIs/test/Custom%20Path/custom_path_model.dart';
import 'package:testapp/utils/size_config.dart';

class JourneyPageLogic {
  static double? pageWidth, pageHeight, currentFullViewHeight;
  static int? bottomPage, pageCount;
  static List<JourneyPage>? pages;
  static List<MilestoneModel> currentMilestoneList = [];
  static List<JourneyPathModel> journeyPathItemsList = [];
  static List<CustomPathModel> customPathDataList = [];
  JourneyPageLogic(int stPage, int pgCount, List<JourneyPage> pgs) {
    pageWidth = SizeConfig.width;
    pageHeight = pageWidth! * 2.165;
    bottomPage = stPage;
    pageCount = pgCount;
    currentFullViewHeight = pageHeight! * pgCount;
    pages = pgs;
    setCurrentMilestones(pgs);
    setCurrentPathItems(pgs);
    setJourneyPathItems(pgs);
  }

  setCurrentMilestones(List<JourneyPage> pages) {
    pages.forEach((page) {
      currentMilestoneList.addAll(page.milestones);
    });
  }

  setCurrentPathItems(List<JourneyPage> pages) {
    pages.forEach((page) {
      customPathDataList.addAll(page.avatarPath);
    });
  }

  setJourneyPathItems(List<JourneyPage> pages) {
    pages.forEach((page) {
      journeyPathItemsList.addAll(page.path);
    });
  }
  // setDimensions(BuildContext context) {
  //   JourneyPageLogic.pageHeight = MediaQuery.of(context).size.width * 2.165;
  //   JourneyPageLogic.pageWidth = MediaQuery.of(context).size.width;
  //   JourneyPageLogic.currentFullViewHeight = JourneyPageLogic.pageHeight! * noOfSlides;
  // }

  static Path drawPath() {
    // Size size = Size(JourneyPageLogic.pageWidth!!, JourneyPageLogic.pageHeight!);
    Path path = Path();
    for (int i = 0; i < customPathDataList.length; i++) {
      path = JourneyPageLogic.generateCustomPath(path, customPathDataList[i],
          i == 0 ? PathType.move : customPathDataList[i].pathType);
    }
    return path;
  }

  static Path generateCustomPath(
      Path path, CustomPathModel model, PathType pathType) {
    switch (pathType) {
      case PathType.linear:
        path.lineTo(
            pageWidth! * model.cords[0],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[1]);
        return path;
      case PathType.arc:
        return path;
      case PathType.move:
        path.moveTo(
            pageWidth! * model.cords[0],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[1]);
        return path;
      case PathType.rect:
        return path;
      case PathType.quadratic:
        path.quadraticBezierTo(
            pageWidth! * model.cords[0],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[1],
            pageWidth! * model.cords[2],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[3]);
        return path;
      case PathType.cubic:
        path.cubicTo(
            pageWidth! * model.cords[0],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[1],
            pageWidth! * model.cords[2],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[3],
            pageWidth! * model.cords[4],
            pageHeight! * (pageCount! - model.page).abs() +
                pageHeight! * model.cords[5]);
        return path;
      default:
        return path;
    }
  }
}

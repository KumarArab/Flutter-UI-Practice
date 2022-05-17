import 'package:flutter/material.dart';

class LadderPainter extends CustomPainter {
  final Color? shadowColor, ladderPrimaryColor, ladderSecondaryColor;

  LadderPainter(
      {@required this.ladderPrimaryColor,
      @required this.ladderSecondaryColor,
      @required this.shadowColor});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9485441, size.height * 0.02871813);
    path_0.lineTo(size.width * 1.627152, size.height * 0.8602733);
    path_0.lineTo(size.width * 1.314800, size.height * 0.9999913);
    path_0.lineTo(size.width * 0.6361924, size.height * 0.1684449);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = shadowColor!.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 1.004508, 0);
    path_1.lineTo(size.width * 0.7031554, size.height * 0.1205813);
    path_1.lineTo(size.width * 0.7031554, size.height * 0.1727961);
    path_1.lineTo(size.width * 1.004508, size.height * 0.05221478);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 1.068696, size.height * 0.07706901);
    path_2.lineTo(size.width * 0.7673435, size.height * 0.1976503);
    path_2.lineTo(size.width * 0.7673435, size.height * 0.2498651);
    path_2.lineTo(size.width * 1.068696, size.height * 0.1292838);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 1.131478, size.height * 0.1553912);
    path_3.lineTo(size.width * 0.8301252, size.height * 0.2759725);
    path_3.lineTo(size.width * 0.8301252, size.height * 0.3281873);
    path_3.lineTo(size.width * 1.131478, size.height * 0.2076060);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 1.194259, size.height * 0.2337133);
    path_4.lineTo(size.width * 0.8929069, size.height * 0.3542947);
    path_4.lineTo(size.width * 0.8929069, size.height * 0.4065094);
    path_4.lineTo(size.width * 1.194259, size.height * 0.2859281);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 1.257041, size.height * 0.3120355);
    path_5.lineTo(size.width * 0.9556887, size.height * 0.4326168);
    path_5.lineTo(size.width * 0.9556887, size.height * 0.4848316);
    path_5.lineTo(size.width * 1.257041, size.height * 0.3642503);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 1.319823, size.height * 0.3903577);
    path_6.lineTo(size.width * 1.018470, size.height * 0.5109390);
    path_6.lineTo(size.width * 1.018470, size.height * 0.5631538);
    path_6.lineTo(size.width * 1.319823, size.height * 0.4425724);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 1.382604, size.height * 0.4686798);
    path_7.lineTo(size.width * 1.081252, size.height * 0.5892612);
    path_7.lineTo(size.width * 1.081252, size.height * 0.6414759);
    path_7.lineTo(size.width * 1.382604, size.height * 0.5208946);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 1.445386, size.height * 0.5470020);
    path_8.lineTo(size.width * 1.144034, size.height * 0.6675833);
    path_8.lineTo(size.width * 1.144034, size.height * 0.7197981);
    path_8.lineTo(size.width * 1.445386, size.height * 0.5992168);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 1.508168, size.height * 0.6253242);
    path_9.lineTo(size.width * 1.206816, size.height * 0.7459055);
    path_9.lineTo(size.width * 1.206816, size.height * 0.7981203);
    path_9.lineTo(size.width * 1.508168, size.height * 0.6775389);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 1.570950, size.height * 0.7036463);
    path_10.lineTo(size.width * 1.269597, size.height * 0.8242277);
    path_10.lineTo(size.width * 1.269597, size.height * 0.8764424);
    path_10.lineTo(size.width * 1.570950, size.height * 0.7558611);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = ladderPrimaryColor!.withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 1.004508, size.height * 0.05096162);
    path_11.lineTo(size.width * 0.7017365, size.height * 0.1721173);
    path_11.lineTo(size.width * 0.7670295, size.height * 0.1982247);
    path_11.lineTo(size.width * 1.069801, size.height * 0.07706901);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 1.068696, size.height * 0.1280393);
    path_12.lineTo(size.width * 0.7659371, size.height * 0.2491863);
    path_12.lineTo(size.width * 0.8312301, size.height * 0.2752937);
    path_12.lineTo(size.width * 1.133939, size.height * 0.1541467);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 1.131478, size.height * 0.2063615);
    path_13.lineTo(size.width * 0.8287189, size.height * 0.3275085);
    path_13.lineTo(size.width * 0.8940119, size.height * 0.3536159);
    path_13.lineTo(size.width * 1.196720, size.height * 0.2324689);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 1.194259, size.height * 0.2846837);
    path_14.lineTo(size.width * 0.8915006, size.height * 0.4058307);
    path_14.lineTo(size.width * 0.9567936, size.height * 0.4319380);
    path_14.lineTo(size.width * 1.259565, size.height * 0.3107911);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 1.257041, size.height * 0.3630058);
    path_15.lineTo(size.width * 0.9542823, size.height * 0.4841528);
    path_15.lineTo(size.width * 1.019575, size.height * 0.5102602);
    path_15.lineTo(size.width * 1.322347, size.height * 0.3891132);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 1.319823, size.height * 0.4413280);
    path_16.lineTo(size.width * 1.017064, size.height * 0.5624750);
    path_16.lineTo(size.width * 1.082357, size.height * 0.5885824);
    path_16.lineTo(size.width * 1.385128, size.height * 0.4674354);
    path_16.close();

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 1.382604, size.height * 0.5196502);
    path_17.lineTo(size.width * 1.079846, size.height * 0.6407971);
    path_17.lineTo(size.width * 1.145139, size.height * 0.6669045);
    path_17.lineTo(size.width * 1.447910, size.height * 0.5457575);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 1.445386, size.height * 0.5979723);
    path_18.lineTo(size.width * 1.142628, size.height * 0.7191193);
    path_18.lineTo(size.width * 1.207921, size.height * 0.7452267);
    path_18.lineTo(size.width * 1.510692, size.height * 0.6240797);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_18, paint_18_fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 1.508168, size.height * 0.6762945);
    path_19.lineTo(size.width * 1.205409, size.height * 0.7974415);
    path_19.lineTo(size.width * 1.270702, size.height * 0.8235489);
    path_19.lineTo(size.width * 1.573473, size.height * 0.7024019);
    path_19.close();

    Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
    paint_19_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_19, paint_19_fill);

    Path path_20 = Path();
    path_20.moveTo(size.width * 1.570950, size.height * 0.7546167);
    path_20.lineTo(size.width * 1.268191, size.height * 0.8757636);
    path_20.lineTo(size.width * 1.333484, size.height * 0.9018710);
    path_20.lineTo(size.width * 1.636255, size.height * 0.7807240);
    path_20.close();

    Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
    paint_20_fill.color = ladderSecondaryColor!.withOpacity(1.0);
    canvas.drawPath(path_20, paint_20_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

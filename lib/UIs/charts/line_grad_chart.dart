import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testapp/UIs/charts/chart_model.dart';
import 'package:testapp/UIs/charts/chart_style.dart';
import 'package:testapp/utils/size_config.dart';

class LineGradientChart extends StatefulWidget {
  const LineGradientChart({Key? key}) : super(key: key);

  @override
  State<LineGradientChart> createState() => _LineGradientChartState();
}

class _LineGradientChartState extends State<LineGradientChart> {
  List<ChartData>? chartData;
  double lastItem = 25;

  @override
  void initState() {
    chartData = [
      ChartData(day: 18, price: 6547),
      ChartData(day: 19, price: 6562),
      ChartData(day: 20, price: 6585),
      ChartData(day: 21, price: 6345),
      ChartData(day: 22, price: 6953),
      ChartData(day: 23, price: 6467),
      ChartData(day: 24, price: 6925),
      ChartData(day: 25, price: 6638),
      ChartData(day: 26, price: 6385),
      ChartData(day: 27, price: 6836),
      ChartData(day: 28, price: 6653),
      ChartData(day: 29, price: 6958),
      ChartData(day: 30, price: 6284),
      ChartData(day: 31, price: 6594),
      ChartData(day: 32, price: 6136),
      ChartData(day: 33, price: 6956),
      ChartData(day: 34, price: 6355),
      ChartData(day: 35, price: 6764),
      ChartData(day: 36, price: 6938),
      ChartData(day: 37, price: 6630),
      ChartData(day: 38, price: 7000),
      ChartData(day: 39, price: 6374),
      ChartData(day: 40, price: 6468),
      ChartData(day: 41, price: 6938),
      ChartData(day: 42, price: 6368),
      ChartData(day: 43, price: 6732),
      ChartData(day: 44, price: 6793),
      ChartData(day: 45, price: 6544),
    ];

    super.initState();
  }

  void updateChartData() {
    setState(() {
      chartData!.addAll([
        ChartData(day: 27, price: 6836),
        ChartData(day: 28, price: 6653),
        ChartData(day: 29, price: 6958),
        ChartData(day: 30, price: 6284),
        ChartData(day: 31, price: 6594),
        ChartData(day: 32, price: 6136),
        ChartData(day: 33, price: 6956),
        ChartData(day: 34, price: 6355),
        ChartData(day: 35, price: 6764),
        ChartData(day: 36, price: 6938),
        ChartData(day: 37, price: 6630),
        ChartData(day: 38, price: 7000),
        ChartData(day: 39, price: 6374),
        ChartData(day: 40, price: 6468),
        ChartData(day: 41, price: 6938),
        ChartData(day: 42, price: 6368),
        ChartData(day: 43, price: 6732),
        ChartData(day: 44, price: 6793),
        ChartData(day: 45, price: 6544),
      ]);
    }); //refresh the widget to show updated data in UI
  }

  void updateChartData2() {
    setState(() {
      lastItem += 5;
    }); //refresh the widget to show updated data in UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChartStyle.bg_color,
      appBar: AppBar(
        backgroundColor: ChartStyle.bg_color,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Gold Rate Graph",
          style: GoogleFonts.raleway(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Text(
                "Historic Returns  ",
                style: GoogleFonts.rajdhani(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.fontSize,
                ),
              ),
              GestureDetector(
                onTap: updateChartData2,
                child: const Icon(
                  Icons.thumbs_up_down,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                "11.5% ",
                style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.titleSize,
                    color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: SizeConfig.mFontSize! * 0.3),
                child: Text(
                  "(1 year)",
                  style: GoogleFonts.sourceSansPro(
                      fontSize: SizeConfig.mFontSize! * 0.7,
                      color: Colors.white),
                ),
              )
            ],
          ),
          SfCartesianChart(
            margin: EdgeInsets.zero,
            borderWidth: 0,
            borderColor: ChartStyle.bg_color,
            plotAreaBorderWidth: 0,
            primaryXAxis: NumericAxis(
              minimum: chartData!.first.day.toDouble(),
              maximum: lastItem,
              // maximum: chartData!.last.day.toDouble(),
              interval: 100,
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
            ),
            primaryYAxis: NumericAxis(
              minimum: 6000,
              maximum: 7000,
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
            ),
            series: <ChartSeries<ChartData, int>>[
              SplineAreaSeries(
                dataSource: chartData!,
                xValueMapper: (ChartData data, _) => data.day,
                yValueMapper: (ChartData data, _) => data.price,
                splineType: SplineType.natural,
                animationDuration: 4000,
                enableTooltip: true,
                gradient: LinearGradient(colors: [
                  ChartStyle.spline_color,
                  ChartStyle.bg_color.withOpacity(0.02),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              SplineSeries(
                color: ChartStyle.accent_color,
                width: 1,
                animationDuration: 4000,
                enableTooltip: true,

                // markerSettings: const MarkerSettings(
                //     isVisible: true,
                //     color: ChartStyle.spline_color,
                //     width: 4,
                //     shape: DataMarkerType.circle,
                //     borderColor: ChartStyle.accent_color),
                dataSource: chartData!,
                xValueMapper: (ChartData data, _) => data.day,
                yValueMapper: (ChartData data, _) => data.price,
                splineType: SplineType.natural,
              )
            ],
          )
        ],
      ),
    );
  }
}

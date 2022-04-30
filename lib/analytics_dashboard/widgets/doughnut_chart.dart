import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';


class DOUGHNUT extends StatelessWidget {
  const DOUGHNUT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoughnutChart(title: 'Bar Chart', chartData: [],),
    );
  }
}

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({Key? key, required this.title, required this.chartData})
      : super(key: key);

  final String title;
  // TODO : use custom model for the data list
  final List<double> chartData;
  @override
  State<DoughnutChart> createState() => DoughnutChartState();
}

class DoughnutChartState extends State<DoughnutChart> {
  late List<ChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  List<ChartData> continent = [];
  List<ChartData> gdp = [];

  @override
  void initState() {
    _chartData = widget.chartData.cast<ChartData>();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCircularChart(
        title: ChartTitle(text: 'Doughnut Chart'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
              dataSource: _chartData,
              xValueMapper: (ChartData data, _) => data.continent,
              yValueMapper: (ChartData data, _) => data.gdp,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true)
        ],
      ),
    ));
  }
}

class ChartData {
  ChartData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

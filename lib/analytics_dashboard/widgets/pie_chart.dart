import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PIE extends StatelessWidget {
  const PIE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PieChart(title: 'Bar Chart', chartData: [],),
    );
  }
}

class PieChart extends StatefulWidget {
  const PieChart({Key? key, required this.title, required this.chartData})
      : super(key: key);

  final String title;
  // TODO : use custom model for the data list
  final List<double> chartData;
  @override
  State<PieChart> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
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
        title: ChartTitle(text: 'Pie Chart'),
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
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

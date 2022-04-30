
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BAR extends StatelessWidget {
  const BAR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BarChart(title: 'Bar Chart', chartData: [],),
    );
  }
}


class BarChart extends StatefulWidget {
  const BarChart({Key? key, required this.title, required this.chartData})
      : super(key: key);

  final String title;
  // TODO : use custom model for the data list
  final List<double> chartData;
  @override
  State<BarChart> createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
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
        body: SfCartesianChart(
            title: ChartTitle(text: 'Bar Chart'),
            legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,
            series: <ChartSeries>[
              BarSeries<ChartData, String>(
                  // name: '',
                  dataSource: _chartData,
                  xValueMapper: (ChartData gdp, _) => gdp.continent,
                  yValueMapper: (ChartData gdp, _) => gdp.gdp,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  enableTooltip: true)
            ],
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                title: AxisTitle(text: 'Bar chart'))),
      ),
    );
  }
}

class ChartData {
  ChartData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}

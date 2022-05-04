import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class LINE extends StatelessWidget {
  const LINE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LineChart(
        title: 'Bar Chart',
        chartData: [],
      ),
    );
  }
}

class LineChart extends StatefulWidget {
  const LineChart({Key? key, required this.title, required this.chartData})
      : super(key: key);

  final String title;
  // TODO : use custom model for the data list
  final List<double> chartData;
  @override
  State<LineChart> createState() => LineChartState();
}

class LineChartState extends State<LineChart> {
  late List<ChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  List<ChartData> sales = [];
  List<ChartData> year = [];

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
          title: ChartTitle(text: "Line Chart"),
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            LineSeries<ChartData, double>(
                name: 'Sales',
                dataSource: _chartData,
                xValueMapper: (ChartData sales, _) => sales.sales,
                yValueMapper: (ChartData sales, _) => sales.year,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true)
          ],
          primaryXAxis:
              NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
          primaryYAxis: NumericAxis(
              labelFormat: '{value}M',
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.sales, this.year);
  final double sales;
  final int year;
}

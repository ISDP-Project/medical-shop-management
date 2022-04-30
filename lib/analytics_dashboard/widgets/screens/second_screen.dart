
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../barchart.dart';
import '../bar_chart.dart';
// import '../../graph_page.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
            ),
            child: const Text('Bar Graph', style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BAR()),
              );
            },
          ),
        ),
      );
}

import 'package:flutter/material.dart';

import '../doughnut_chart.dart';

// import '../../barchart.dart';
// import '../../graph_page.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Third Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
            ),
            child: const Text('Doughut Graph', style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DOUGHNUT()),
              );
            },
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pharmacy_app/analytics_dashboard/widgets/screens/fifth_screen.dart';
import 'package:pharmacy_app/analytics_dashboard/widgets/screens/fourth_screen.dart';
import 'package:pharmacy_app/analytics_dashboard/widgets/screens/second_screen.dart';
import 'package:pharmacy_app/analytics_dashboard/widgets/screens/third_screen.dart';
// import 'analytics_dashboard/widgets/screens/fifth_screen.dart';
// import 'analytics_dashboard/widgets/screens/fourth_screen.dart';
// import 'analytics_dashboard/widgets/screens/second_screen.dart';
// // import 'analytics_dashboard/graph_page.dart';

// // import 'package:dashboard/analytics_dashboard/barchart.dart';

// import 'analytics_dashboard/widgets/screens/third_screen.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.green,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.bar_chart, color: Colors.green),
            label: 'bar graph',
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>const SecondScreen() ),);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.donut_large_sharp, color: Colors.green),
            label: 'doughnut graph',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThirdScreen()),
              );
            },
          ),
          SpeedDialChild(
              child: Icon(Icons.pie_chart, color: Colors.green),
              label: 'pie graph',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FifthScreen()),
              );
            },
              ),
          SpeedDialChild(
              child: Icon(Icons.auto_graph, color: Colors.green),
              label: 'line graph',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FourthScreen()),
              );
            },              
              )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          "Analytics Dashboard",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

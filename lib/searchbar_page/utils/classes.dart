import 'package:flutter/material.dart';

//class Myapp
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,
      title: 'Medicine searchbar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

//class Homescreen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//class HomeScreenstate
class _HomeScreenState extends State<HomeScreen> {
  List medicineList = [
    'Amoxicillin 500 mg by Trimox ',
    'Vitamin D 50,000 IU by Drisdol',
    'Ibuprofen 800 mg by Motrin',
    'Cetirizine hydrochloride 10 mg by Zyrtec',
    'Azithromycin 250 mg by Zithromax ',
    'Amlodipine besylate 10 mg by Norvasc ',
    'Albuterol sulfate HFA 90 mcg/act by Proventil HFA',
    'Albuterol sulfate HFA 90 mcg/act by Proair HFA',
    'Albuterol sulfate HFA 90 mcg/act by Ventolin HFA',
    'Cephalexin 500 mg	Keflex by medicare',
    'Hydrochlorothiazide 25 mg by jaison',
    'Atorvastatin 30 mg by kep',
    'Amoxicillin 20mg by Lipitor',
    'Lisinopril 10mg by Trimox',
    'Albuterol	45mg by	Ventolin',
    'Metformin	60mg by	Glucophage',
    'Amlodipine	35mg by	Norvasc',
    'Metoprolol	20mg by	Lopressor',
    'Omeprazole	60mg by	Losec',
    'Losartan	85mg by	Cozaar',
  ];

  @override
  Widget build(BuildContext context) => throw UnimplementedError();
}
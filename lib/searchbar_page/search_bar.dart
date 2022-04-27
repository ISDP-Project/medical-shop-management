// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
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
  List? medicineListSearch;
  final FocusNode _textFocusNode = FocusNode();
  // ignore: prefer_final_fields
  TextEditingController? _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
              decoration: BoxDecoration(color: Colors.blue.shade200),
              // ignore: duplicate_ignore
              child: TextField(
                controller: _textEditingController,
                focusNode: _textFocusNode,
                cursorColor: Colors.black,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: '  Search  your Required  Medicine   here.............',
                    contentPadding: EdgeInsets.all(15)),
                onChanged: (value) {
                  setState(() {
                    medicineListSearch = medicineList
                        .where(
                            (element) => element.contains(value.toLowerCase()))
                        .toList();
                    if (_textEditingController!.text.isNotEmpty &&
                        // ignore: prefer_is_empty
                        medicineListSearch!.length == 0) {
                      print('medicineListSearch length ${medicineListSearch!.length}');
                    }
                  });
                },
              ),
            )),
        body: _textEditingController!.text.isNotEmpty &&
                // ignore: prefer_is_empty
                medicineListSearch!.length == 0
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search_off,
                          size: 100,
                          //color: Color.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No Medicine found , Please spelling check or try different Medicine',
                          style: TextStyle(  fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _textEditingController!.text.isNotEmpty
                    ? medicineListSearch!.length
                    : medicineList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.medication),
                        ),
                        SizedBox(width: 10,),
                        Text(_textEditingController!.text.isNotEmpty
                            ? medicineListSearch![index]
                            : medicineList[index]),
                      ],
                    ),
                  );
                }));
  }
}
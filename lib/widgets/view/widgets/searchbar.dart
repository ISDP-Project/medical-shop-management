import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(appBar: AppBar(title: Text('MEDICINE SEARCHBAR')), body: Center(child: ListSearch())));
  }
}

class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {
  TextEditingController _textController = TextEditingController();

  static List<String> medList = [
    'Amoxicillin 500 mg by Trimox ',
    'Vitamin D 50,000 IU by Drisdol',
    'Ibuprofen 800 mg by Motrin',
    'Cetirizine hydrochloride 10 mg by Zyrtec',
    'Azithromycin 250 mg by Zithromax ',
    'Amlodipine besylate 10 mg by Norvasc ',
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

  // Copy Main List into New List.
  List<String> newDataList = List.from(medList);

  onItemChanged(String value) {
    setState(() {
      newDataList = medList.where((string) => string.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search your medicines Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newDataList.map((data) {
                return ListTile(
                  title: Text(data),
                  onTap: () => print(data),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

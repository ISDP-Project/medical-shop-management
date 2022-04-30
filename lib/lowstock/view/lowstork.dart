import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/authentication.dart';
import '../../constants/constants.dart';
import '../data/medicines.dart';
import '../models/medicine.dart';

class Lowstock extends StatefulWidget {
  Lowstock() : super();
  final String title = 'Low Stock Widget';
  @override
  _LowstockState createState() => _LowstockState();
}
class _LowstockState extends State<Lowstock> {

  late List<Medicine> medicines;
  late List<Medicine> selectedMedicines;
  late bool sort;



  @override
  void initState() {
    sort = false;
    selectedMedicines = [];
    medicines = allMedicines.cast<Medicine>();
    super.initState();
  }
  void onSortColum(int columnIndex, bool ascending) {
     if (columnIndex == 0) {
      var medicine1;
      var medicine2;
      medicines.sort((medecine1, medecine2) =>
          compareString(ascending, medicine1.medicineName, medicine2.medicineName));
    }else if (columnIndex == 1) {
      medicines.sort((medicine1, medicine2) =>
          compareString(ascending, '${medicine1.stock}', '${medicine2.stock}'));
    }
  }
   int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  onSelectedRow(bool selected, Medicine medicine) async {
    setState(() {
      if (selected) {
        selectedMedicines.add(medicine);
      } else {
        selectedMedicines.remove(medicine);
      }
    });
  }
  deleteSelected() async {
    setState(() {
      if (selectedMedicines.isNotEmpty) {
        List<Medicine> temp = [];
        temp.addAll(selectedMedicines);
        for (Medicine medicine in temp) {
          medicines.remove(medicine);
          selectedMedicines.remove(medicine);
        }
      }
    });
  }

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //   body: ScrollableWidget(child: buildDataTable()),
  // );

  //Widget buildDataTable() {
   // final columns = ['Medicine Name', 'Stock'];
    SingleChildScrollView dataBody(){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          sortAscending: sort,
          sortColumnIndex: 0,
          columns: [
            DataColumn(
              label: Text("Medicine Name"),
              numeric: false,
              tooltip: "This is Medicine Name",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("Stock"),
            numeric: true,
            tooltip: "This is the stock",
            onSort: (columnIndex, ascending){
              setState(() {
                sort = !sort;
              });
              onSortColum(columnIndex, ascending);
            }  
          ),
          ],
          rows: medicines
          .map(
            (medicine) => DataRow(
                    selected: selectedMedicines.contains(medicine),
                    onSelectChanged: (medicine2) {
                    print("Onselect");
                    onSelectedRow(medicine2!, medicine);
                    },
                    cells: [
                    DataCell(
                        Text(medicine.medicineName),
                        onTap: () {
                        print('Selected ${medicine.medicineName}');
                        },
                    ),
                    DataCell(
                        Text(medicine.stock.toString()),
                    ),
                    ]),
        )
        .toList(),
        )
    );
    }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
        
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('SELECTED ${selectedMedicines.length}'),
                  onPressed: () {  },
                   ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: selectedMedicines.isEmpty
                      ? null:
                  () { 
                    deleteSelected();
                  },
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  }
  



 
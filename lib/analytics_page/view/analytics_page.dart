import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text('Today'),
                
              ),
              
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Last 7 Days'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Last 30 Days'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Last 365 Days'),
              ),
              const PopupMenuItem<int>(
                  value: 4, child: Text('Custom Range...')),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    late final startDate;
    final endDate = DateTime.now();
    final DateRangePickerController _dateRangePickerController =
        DateRangePickerController();
    switch (item) {
      case 0:
        startDate = endDate.subtract(const Duration(hours: 24));
        debugPrint('The selected range of date is: $endDate to $startDate');
        break;
      case 1:
        startDate = endDate.subtract(const Duration(days: 7));
        debugPrint('The selected range of date is: $endDate to $startDate');
        break;
      case 2:
        startDate = endDate.subtract(const Duration(days: 30));
        debugPrint('The selected range of date is: $endDate to $startDate');
        break;
      case 3:
        startDate = endDate.subtract(const Duration(days: 365));
        debugPrint('The selected range of date is: $endDate to $startDate');
        break;
      case 4:
        Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.multiRange,
          showTodayButton: true,
          showActionButtons: true,
          controller: _dateRangePickerController,
          // onSubmit: (Object val) {
          //   print(val);
          // },
          onCancel: () {
            _dateRangePickerController.selectedRanges = null;
          },
        ),
       ),
      );
        
      break;
    }
  }
}

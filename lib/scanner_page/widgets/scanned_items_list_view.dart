import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';

class ScannedItemsListView extends StatelessWidget {
  const ScannedItemsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScannerBloc, ScannerState, List<String>>(
      selector: (state) {
        return state.items;
      },
      builder: (context, items) {
        return Container(
          height: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: const Icon(Icons.medication),
                title: Text(
                  items[i],
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

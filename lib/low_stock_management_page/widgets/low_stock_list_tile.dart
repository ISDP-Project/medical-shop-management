import 'package:flutter/material.dart';

import 'package:recase/recase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../bloc/lowstock_bloc.dart';
import '../../constants/constants.dart';

class LowStockListTile extends StatelessWidget {
  const LowStockListTile({
    Key? key,
    required this.medicine,
    required this.onChanged,
  }) : super(key: key);

  final Medicine medicine;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        tileColor: Theme.of(context).colorScheme.surface,
        title: Text(
          LowStockPageConstants.medicineTileHeading
              .replaceFirst(
                  LowStockPageConstants.replace1, medicine.name.titleCase)
              .replaceFirst(LowStockPageConstants.replace2,
                  medicine.manufacturer.titleCase),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        value: context.select((LowStockBloc bloc) =>
                bloc.state.changedIds!.contains(medicine.barcodeId))
            ? !medicine.shouldNotify
            : medicine.shouldNotify,
        onChanged: (v) {
          onChanged(v);
        });
  }
}

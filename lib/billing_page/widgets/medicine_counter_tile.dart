import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../bloc/bill_bloc.dart';
import '../../constants/constants.dart';

class MedicineCounterTile extends StatelessWidget {
  const MedicineCounterTile({
    Key? key,
    required this.medicine,
  }) : super(key: key);

  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(
          kDefaultBorderRadius * 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              context
                  .read<BillBloc>()
                  .add(BillEventItemStagedDecrement(medicine));
            },
            icon: const Icon(Icons.remove),
          ),
          Text(
            '${context.read<BillBloc>().state.stagedItems![medicine]}',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<BillBloc>()
                  .add(BillEventItemStagedIncrement(medicine));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

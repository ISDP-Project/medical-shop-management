import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../bloc/inventory_bloc.dart';
import '../../constants/constants.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc(context.read<PharmacyDataRepository>())
        ..add(const InventoryEventLoadRequested()),
      child: const InventoryPageView(),
    );
  }
}

class InventoryPageView extends StatelessWidget {
  const InventoryPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Inventory'),
          ],
        ),
        elevation: kDefaultAppBarElevation,
      ),
      body: SafeArea(
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if (state is InventoryStateInitial) {
              return Container();
            }

            if (state is InventoryStateLoading) {
              return Center(
                child: SpinKitDualRing(
                  color: Theme.of(context).colorScheme.primary,
                  size: kDefaultLoadingIndicatorSize,
                ),
              );
            }

            if (state is InventoryStateError) {
              return Text(
                BillingPageConstants.networkErrorMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              );
            }

            return Container(
              margin: const EdgeInsets.only(
                top: kDefaultMargin * 2,
                left: kDefaultMargin * 1.25,
                right: kDefaultMargin * 1.25,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.medicines?.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: kDefaultMargin),
                    child: Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              kDefaultBorderRadius * 0.25),
                        ),
                        tileColor: Theme.of(context).colorScheme.surface,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.medicines?[i].name.titleCase ??
                                        'Nicip Plus',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    'Med',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.medicines?[i].manufacturer.titleCase ??
                                        'Cipla',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    'Manufacturer',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.medicines?[i].quantity.toString() ??
                                        '2',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    'Qty.',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.medicines?[i].mrp.toString() ?? '12.5',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    'MRP.',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

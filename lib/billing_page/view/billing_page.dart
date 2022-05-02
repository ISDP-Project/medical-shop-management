import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_app/authentication/authentication.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../bloc/bill_bloc.dart';
import '../widgets/widgets.dart';
import '../../constants/constants.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillBloc(
        pharmacyDataRepository: context.read<PharmacyDataRepository>(),
      )..add(const BillEventLoadRequested()),
      child: const BillPageView(),
    );
  }
}

class BillPageView extends StatelessWidget {
  const BillPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(BillingPageConstants.appBarHeading),
          ],
        ),
        elevation: kDefaultAppBarElevation,
        actions: [
          IconButton(
            onPressed: () {
              context.read<BillBloc>().add(const BillEventClearBillRequested());
            },
            icon: const Icon(Icons.replay),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<BillBloc>()
                  .add(const BillEventBillGenerationRequested());
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<BillBloc, BillState>(
          builder: (context, state) {
            if (state is BillStateInitial) {
              return Container();
            }

            if (state is BillStateLoading) {
              return Center(
                child: SpinKitDualRing(
                  color: Theme.of(context).colorScheme.primary,
                  size: kDefaultLoadingIndicatorSize,
                ),
              );
            }

            if (state is BillStateError) {
              return Text(
                BillingPageConstants.networkErrorMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(
                  vertical: kDefaultMargin * 2,
                  horizontal: kDefaultMargin * 1.25),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 1.5,
                vertical: kDefaultPadding * 2,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(kDefaultBorderRadius * 0.5),
                boxShadow: const [kDefaultBoxShadow],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('d.M.y').format(DateTime.now().toLocal()),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .pharmacyName,
                        // style: Theme.of(context).textTheme.bodyText1,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding * 1.15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        BillingPageConstants.productName,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                            ),
                      ),
                      Text(
                        BillingPageConstants.price,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2?.color,
                            ),
                      ),
                    ],
                  ),
                  Expanded(
                    child:
                        BlocSelector<BillBloc, BillState, Map<Medicine, int>?>(
                      selector: (state) => state.itemsInBill,
                      builder: (context, itemsInBill) {
                        return ListView.builder(
                          itemCount: itemsInBill!.length,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  top: kDefaultPadding * 0.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${itemsInBill.keys.elementAt(i).name.titleCase} x${itemsInBill[itemsInBill.keys.elementAt(i)]}',
                                  ),
                                  Text(
                                    '₹ ${itemsInBill.keys.elementAt(i).mrp.toString()}',
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () => _show(context),
      ),
    );
  }

  void _show(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius * 0.5),
      ),
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: context.read<BillBloc>(),
          child: const AddItemBottomSheet(),
        );
      },
    );
  }
}

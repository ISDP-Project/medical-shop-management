import 'dart:developer';

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
    final Bill? bill = (ModalRoute.of(context)?.settings.arguments as Bill?);

    return BlocProvider(
      create: (context) => BillBloc(
        pharmacyDataRepository: context.read<PharmacyDataRepository>(),
      )..add(bill == null
          ? const BillEventLoadRequested()
          : BillEventInitializeFromBillObject(bill)),
      child: BillPageView(
        bill: bill,
      ),
    );
  }
}

class BillPageView extends StatelessWidget {
  const BillPageView({
    Key? key,
    Bill? bill,
  })  : _bill = bill,
        super(key: key);
  final Bill? _bill;

  @override
  Widget build(BuildContext context) {
    log(_bill.toString());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _bill != null
                  ? BillingPageConstants.billHistoryAppBarHeading
                  : BillingPageConstants.billGenAppBarHeading,
            ),
          ],
        ),
        elevation: kDefaultAppBarElevation,
        actions: _bill != null
            ? null
            : [
                IconButton(
                  onPressed: () {
                    context
                        .read<BillBloc>()
                        .add(const BillEventClearBillRequested());
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
                        DateFormat(kDefaultDateFormat).format(
                          _bill == null
                              ? DateTime.now().toLocal()
                              : _bill!.date,
                        ),
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
                          itemCount: itemsInBill!.length + 2,
                          itemBuilder: (context, i) {
                            if (i == itemsInBill.length) {
                              return const Divider();
                            }

                            return Container(
                              padding: const EdgeInsets.only(
                                  top: kDefaultPadding * 1.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        i == itemsInBill.length + 1
                                            ? BillingPageConstants
                                                .billTotalLabel
                                            : '${itemsInBill.keys.elementAt(i).name.titleCase} x${itemsInBill[itemsInBill.keys.elementAt(i)]}',
                                      ),
                                      if (i < itemsInBill.length)
                                        Text(
                                          '₹${itemsInBill.keys.elementAt(i).mrp}',
                                        ),
                                    ],
                                  ),
                                  Text(
                                    i == itemsInBill.length + 1
                                        ? '₹ ${state.totalPrice}'
                                        : '₹ ${itemsInBill.keys.elementAt(i).mrp * itemsInBill[itemsInBill.keys.elementAt(i)]!}',
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
      floatingActionButton: _bill != null
          ? null
          : FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => _show(context),
            ),
    );
  }

  void _show(BuildContext context) {
    final bloc = context.read<BillBloc>();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius * 0.5),
      ),
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: bloc,
          child: const AddItemBottomSheet(),
        );
      },
    );
  }
}

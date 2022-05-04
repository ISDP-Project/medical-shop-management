import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../../routes.dart';
import '../bloc/bill_history_bloc.dart';
import '../../constants/constants.dart';
import '../../billing_page/billing_page.dart';

class BillHistory extends StatelessWidget {
  const BillHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BillHistoryBloc(context.read<PharmacyDataRepository>())
            ..add(const BillHistoryEventLoadRequested()),
      child: const BillHistoryView(),
    );
  }
}

class BillHistoryView extends StatelessWidget {
  const BillHistoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(BillHistoryPageConstants.appBarTitle),
          ],
        ),
        elevation: kDefaultAppBarElevation,
      ),
      body: SafeArea(
        child: BlocBuilder<BillHistoryBloc, BillHistoryState>(
          builder: (context, state) {
            if (state is BillHistoryStateInitial) {
              return Container();
            }

            if (state is BillHistoryStateLoading) {
              return Center(
                child: SpinKitDualRing(
                  color: Theme.of(context).colorScheme.primary,
                  size: kDefaultLoadingIndicatorSize,
                ),
              );
            }

            if (state is BillHistoryStateError) {
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
                itemCount: state.bills?.length,
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
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.billPage,
                              arguments: state.bills![i]);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.bills![i].id.substring(0, 8),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Text(
                                  'Bill ID',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  DateFormat('MMM d, yyyy')
                                      .format(state.bills![i].date),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  'Date',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  state.bills![i].price.toString(),
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  'Total',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
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

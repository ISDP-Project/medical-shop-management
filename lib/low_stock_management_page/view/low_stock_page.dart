import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../bloc/lowstock_bloc.dart';
import '../widgets/widgets.dart';
import '../../constants/constants.dart';

class LowStockPage extends StatelessWidget {
  const LowStockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => LowStockBloc(
        pharmacyDataRepository: context.read<PharmacyDataRepository>(),
      )..add(const LowStockRequestedDataLoad()),
      child: const LowStockPageView(),
    );
  }
}

class LowStockPageView extends StatelessWidget {
  const LowStockPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: kDefaultAppBarElevation,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(LowStockPageConstants.appBarTitle),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<LowStockBloc>()
                  .add(const LowStockSettingsSaveRequested());
            },
            icon: const Icon(Icons.save_sharp),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<LowStockBloc, LowStockState>(
          builder: (context, state) {
            if (state is LowStockStateInitial) {
              return Container();
            }

            if (state is LowStockStateLoading) {
              return Center(
                child: SpinKitDualRing(
                  color: Theme.of(context).colorScheme.primary,
                  size: kDefaultLoadingIndicatorSize,
                ),
              );
            }

            if (state is LowStockStateError) {
              return Text(
                LowStockPageConstants.loadErrorMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              );
            }

            final _bloc = context.read<LowStockBloc>();
            return BlocSelector<LowStockBloc, LowStockState, List<Medicine>?>(
              selector: (state) {
                return state.medicines;
              },
              builder: (context, medicines) {
                log(state.medicines.toString());

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: kDefaultMargin * 1.15),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: medicines!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(top: kDefaultPadding),
                          child: LowStockListTile(
                            medicine: medicines[i],
                            onChanged: (v) {
                              _bloc.add(LowStockRequestedSettingChange(
                                medicines[i],
                              ));
                            },
                          ),
                        );
                      }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

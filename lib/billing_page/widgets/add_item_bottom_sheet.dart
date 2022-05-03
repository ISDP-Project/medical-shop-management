import 'package:flutter/material.dart';

import 'package:recase/recase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './medicine_counter_tile.dart';
import '../bloc/bill_bloc.dart';
import '../../constants/constants.dart';

class AddItemBottomSheet extends StatelessWidget {
  const AddItemBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Container(
            height: MediaQuery.of(context).size.height *
                kDefaultBottomModalSheetRatio,
            margin: const EdgeInsets.symmetric(horizontal: kDefaultMargin * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  margin: const EdgeInsets.symmetric(
                    vertical: kDefaultMargin * 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius:
                        BorderRadius.circular(kDefaultBorderRadius * 0.5),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: kDefaultMargin * 0.4),
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: kDefaultPadding * 0.75),
                      ),
                      Expanded(
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: BillingPageConstants
                                .bottomSheetSearchBarHintText,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<BillBloc, BillState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.medicines?.length ?? 0,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      top: kDefaultPadding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          state.medicines![i].name.titleCase,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.color,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: MedicineCounterTile(
                                            medicine: state.medicines![i]),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<BillBloc>().add(
                                    const BillEventItemAdditionRequested(),
                                  );
                              Navigator.pop(context);
                            },
                            child: const Text(
                              BillingPageConstants.bottomSheetDoneButtonText,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

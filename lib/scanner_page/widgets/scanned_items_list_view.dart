import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';
import '../models/models.dart';
import '../../constants/constants.dart';

class ScannedItemsListView extends StatelessWidget {
  const ScannedItemsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScannerBloc, ScannerState, List<StockItem>>(
      selector: (state) {
        return state.items;
      },
      builder: (context, items) {
        log('rebuild list');
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.only(top: kDefaultMargin * 2),
                    padding: const EdgeInsets.symmetric(
                      vertical: kDefaultPadding * 1.5,
                      horizontal: kDefaultPadding * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      borderRadius:
                          BorderRadius.circular(kDefaultBorderRadius * 0.5),
                      boxShadow: const [kDefaultBoxShadow],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                items[i].item.name ?? '',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: kDefaultPadding),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(
                                    kDefaultBorderRadius * 0.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context.read<ScannerBloc>().add(
                                              ScannerEventItemQuantityDecrement(
                                                  changedItemIdx: i),
                                            );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                          kDefaultPadding * 0.5,
                                        ),
                                        child: const Icon(Icons.remove),
                                      ),
                                    ),
                                    Text(
                                      items[i].quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<ScannerBloc>().add(
                                              ScannerEventItemQuantityIncrement(
                                                  changedItemIdx: i),
                                            );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                          kDefaultPadding * 0.5,
                                        ),
                                        child: const Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: kDefaultPadding),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomStockTextField(
                            hintText: ScannerPageConstants.mfgDateHintText,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 3650)),
                            lastDate: DateTime.now(),
                            controller: items[i].mfgDateController,
                            showDate: true,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: kDefaultPadding),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomStockTextField(
                            hintText: ScannerPageConstants.expDateHintText,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 3650)),
                            controller: items[i].expDateController,
                            showDate: true,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: kDefaultPadding),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomStockTextField(
                            hintText: ScannerPageConstants.costHintText,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 3650)),
                            controller: items[i].costController,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomStockTextField extends StatelessWidget {
  const CustomStockTextField({
    Key? key,
    required this.hintText,
    required this.firstDate,
    required this.lastDate,
    required this.controller,
    this.showDate = false,
  }) : super(key: key);

  final String hintText;
  final DateTime firstDate;
  final DateTime lastDate;
  final TextEditingController controller;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () async {
        if (!showDate) return;
        final DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: firstDate,
            lastDate: lastDate);

        log(selectedDate?.toString() ?? '_');
        if (selectedDate != null) {
          controller.text =
              DateFormat(kDefaultDateFormat).format(selectedDate.toLocal());
        }
      },
      keyboardType: showDate ? TextInputType.none : TextInputType.number,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: kDefaultPadding * 0.5,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultBorderRadius * 0.5,
          ),
        ),
      ),
    );
  }
}

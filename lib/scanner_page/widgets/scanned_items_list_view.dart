import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_repository/barcode_repository.dart';

import '../bloc/scanner_bloc.dart';
import '../../constants/constants.dart';

class ScannedItemsListView extends StatelessWidget {
  const ScannedItemsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _itemCount = 0;
    return BlocSelector<ScannerBloc, ScannerState, List<ScannedBarcodeItem>>(
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
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: kDefaultMargin * 0.75,
                  horizontal: kDefaultMargin * 1.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: Colors.blue, child: Icon(Icons.medication)),
                    Text(
                      (items[i].name?.length ?? 0) > kMaxTitleLength
                          ? '${items[i].name?.substring(0, 40)}...'
                          : items[i].name ?? '',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // height: 35,
                          // width: 100,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              Text("0"),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

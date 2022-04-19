import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scanner_bloc.dart';

class Scanner extends StatelessWidget {
  const Scanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context
                    .read<ScannerBloc>()
                    .add(const ScannerEventScanRequested());
              },
              child: const Text('Barcode scan'),
            ),
            BlocBuilder<ScannerBloc, ScannerState>(
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.items.length,
                  itemBuilder: (context, i) {
                    return Text(state.items[i]);
                  },
                );
              },
            )
          ],
        ),
      );
    });
  }
}

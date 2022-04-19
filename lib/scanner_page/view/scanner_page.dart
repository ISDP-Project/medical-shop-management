import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../bloc/scanner_bloc.dart';
import '../widgets/widgets.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner')),
      body: BlocProvider<ScannerBloc>(
        create: (context) => ScannerBloc(),
        child: const ScannerPageView(),
      ),
    );
  }
}

class ScannerPageView extends StatelessWidget {
  const ScannerPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              BlocSelector<ScannerBloc, ScannerState, bool>(
                selector: (state) {
                  return state.showScannerWidget;
                },
                builder: (context, showScanner) {
                  if (showScanner) {
                    return Expanded(
                      flex: 45,
                      child: SizedBox(
                        height: double.infinity,
                        child: MobileScanner(
                          allowDuplicates: false,
                          fit: BoxFit.fitWidth,
                          controller: MobileScannerController(
                            facing: CameraFacing.back,
                            torchEnabled: false,
                          ),
                          onDetect: (barcode, args) {
                            context.read<ScannerBloc>().add(
                                ScannerEventBarcodeScanned(barcode.rawValue));
                            debugPrint('Barcode found! ${barcode.rawValue}');
                          },
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
              const Expanded(
                flex: 55,
                child: ScannedItemsListView(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () {
          context
              .read<ScannerBloc>()
              .add(const ScannerEventScannerToggleRequested());
        },
      ),
    );
  }
}

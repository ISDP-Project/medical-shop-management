import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerState([])) {
    on<ScannerEventScanRequested>(_scanAndAddItem);
  }

  void _scanAndAddItem(
      ScannerEventScanRequested event, Emitter<ScannerState> emit) async {
    String? item;
    try {
      item = await FlutterBarcodeScanner.scanBarcode(
          '#000000', 'Cancel', true, ScanMode.BARCODE);
      List<String> newList = [...state.items];
      newList.add(item);
      emit(ScannerState(newList));
    } on PlatformException {
      item = 'Failed to get platform version.';
      emit(state);
    }
  }
}

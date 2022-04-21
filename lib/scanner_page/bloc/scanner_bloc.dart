import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerState(items: [])) {
    on<ScannerEventScannerToggleRequested>(_toggleScanner);
    on<ScannerEventBarcodeScanned>(_onBarcodeScanned);
  }

  void _toggleScanner(
      ScannerEventScannerToggleRequested event, Emitter<ScannerState> emit) {
    if (state.showScannerWidget) {
      emit(ScannerState(items: state.items, showScannerWidget: false));
    } else {
      emit(ScannerState(items: state.items, showScannerWidget: true));
    }
  }

  void _onBarcodeScanned(
      ScannerEventBarcodeScanned event, Emitter<ScannerState> emit) {
    if (event.barcodeId != null) {
      List<String> newList = [...state.items];
      newList.add(event.barcodeId ?? '');
      emit(ScannerState(
        items: newList,
        showScannerWidget: state.showScannerWidget,
      ));
    }
  }
}

part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScannerEventScannerToggleRequested extends ScannerEvent {
  const ScannerEventScannerToggleRequested();
}

class ScannerEventBarcodeScanned extends ScannerEvent {
  final String? barcodeId;

  const ScannerEventBarcodeScanned(this.barcodeId);
}

part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState(
    this.items,
    this.showScannerWidget,
    this.inputRequestingItem,
    this.scannedPotentialItems,
  );
  final List<ScannedBarcodeItem> items;
  final bool showScannerWidget;
  final ScannedBarcodeItem? inputRequestingItem;
  final List<ScannedBarcodeItem>? scannedPotentialItems;

  @override
  List<Object> get props => [showScannerWidget, items];
}

class ScannerStateInitial extends ScannerState {
  const ScannerStateInitial() : super(const [], false, null, null);
}

class ScannerStateNormal extends ScannerState {
  const ScannerStateNormal({
    required List<ScannedBarcodeItem> items,
    required bool showScannerWidget,
  }) : super(items, showScannerWidget, null, null);
}

class ScannerStateUserInput extends ScannerState {
  const ScannerStateUserInput({
    required List<ScannedBarcodeItem> items,
    required ScannedBarcodeItem inputRequestingItem,
    bool showScannerWidget = false,
  }) : super(items, showScannerWidget, inputRequestingItem, null);
}

class ScannerStateScannedItemSelector extends ScannerState {
  const ScannerStateScannedItemSelector({
    required List<ScannedBarcodeItem> items,
    required List<ScannedBarcodeItem> potentialScannedItems,
    bool showScannerWidget = false,
  }) : super(items, showScannerWidget, null, potentialScannedItems);
}

class ScannerStateLoading extends ScannerState {
  const ScannerStateLoading({
    required List<ScannedBarcodeItem> items,
    required bool showScannerWidget,
    required ScannedBarcodeItem? inputRequestingItem,
    required List<ScannedBarcodeItem>? scannedPotentialItems,
  }) : super(
          items,
          showScannerWidget,
          inputRequestingItem,
          scannedPotentialItems,
        );
}

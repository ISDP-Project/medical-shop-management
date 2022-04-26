part of 'scanner_bloc.dart';

class ScannerState extends Equatable {
  const ScannerState({
    required this.items,
    this.showScannerWidget = false,
  });
  final List<String> items;
  final bool showScannerWidget;

  @override
  List<Object> get props => [showScannerWidget, items];
}

part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

class ScannerEventScanRequested extends ScannerEvent {
  const ScannerEventScanRequested();
}

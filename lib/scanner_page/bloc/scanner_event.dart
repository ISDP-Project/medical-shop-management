part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object> get props => [];
}

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(int initialState) : super(initialState);

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
    }
  }
}

class ScannerEventScannerToggleRequested extends ScannerEvent {
  const ScannerEventScannerToggleRequested();
}

class ScannerEventBarcodeScanned extends ScannerEvent {
  final String? barcodeId;

  const ScannerEventBarcodeScanned(this.barcodeId);
}

class ScannerBarcodeScannedToInfo extends ScannerEvent {
  final String? response;

  ScannerBarcodeScannedToInfo(this.response);
}

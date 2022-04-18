part of 'scanner_bloc.dart';

class ScannerState extends Equatable {
  const ScannerState(this.items);
  final List<String> items;

  @override
  List<Object> get props => [items];
}

import 'package:equatable/equatable.dart';

class Medicine extends Equatable {
  final int barcodeId;
  final String name;
  final String manufacturer;
  final int quantity;
  final bool shouldNotify;

  @override
  List<Object> get props => [barcodeId];

  const Medicine({
    required this.barcodeId,
    required this.name,
    required this.manufacturer,
    required this.quantity,
    required this.shouldNotify,
  });

  @override
  String toString() {
    return '($barcodeId $manufacturer $name)';
  }
}

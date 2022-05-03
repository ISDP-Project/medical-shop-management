import 'package:equatable/equatable.dart';

class Shipment extends Equatable {
  final DateTime mfgDate;
  final DateTime expDate;
  final double costPrice;
  final String barcodeId;

  Shipment({
    required this.mfgDate,
    required this.expDate,
    required this.costPrice,
    required this.barcodeId,
  });

  @override
  List<Object?> get props => [barcodeId];
}

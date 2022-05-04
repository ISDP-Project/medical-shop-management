import 'package:equatable/equatable.dart';

import './medicine.dart';

class Sale extends Equatable {
  final String uid;
  final Medicine medicine;
  final double price;
  final int quantity;

  Sale({
    required this.uid,
    required this.medicine,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [uid];

  @override
  String toString() {
    return '$medicine : $price';
  }
}

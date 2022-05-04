import 'package:equatable/equatable.dart';
import 'package:pharmacy_data_repository/src/models/sale.dart';

class Bill extends Equatable {
  final DateTime date;
  final String id;
  final List<Sale> sales;
  double? _price;

  Bill(this.sales, this.date, this.id);

  @override
  List<Object?> get props => [sales];

  double get price {
    if (_price != null) return _price!;

    _price = 0;
    for (Sale sale in sales) {
      _price = _price! + sale.price;
    }

    return _price!;
  }

  @override
  String toString() {
    return sales.toString();
  }
}
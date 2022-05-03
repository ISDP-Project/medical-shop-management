import 'package:barcode_repository/barcode_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StockItem extends Equatable {
  final ScannedBarcodeItem item;
  final int quantity;
  final TextEditingController mfgDateController;
  final TextEditingController expDateController;
  final TextEditingController costController;
  const StockItem({
    required this.item,
    required this.mfgDateController,
    required this.expDateController,
    required this.costController,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [item.barcodeId, quantity];
}

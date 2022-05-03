import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import 'package:barcode_repository/barcode_repository.dart';
import 'package:master_db_repository/master_db_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

import '../models/models.dart';
import '../../constants/constants.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final PharmacyDataRepository _pharmacyDataRepository;
  final BarcodeRepository _barcodeRepository;
  final MasterDBHandler _masterDBHandler;
  ScannerBloc({
    required BarcodeRepository barcodeRepository,
    required PharmacyDataRepository pharmacyDataRepository,
    required MasterDBHandler masterDBHandler,
  })  : _barcodeRepository = barcodeRepository,
        _pharmacyDataRepository = pharmacyDataRepository,
        _masterDBHandler = masterDBHandler,
        super(const ScannerStateInitial()) {
    on<ScannerEventScannerToggleRequested>(_toggleScanner);
    on<ScannerEventBarcodeScanned>(_onBarcodeScanned);
    on<ScannerEventMakeChoice>(_onChoiceMade);
    on<ScannerEventItemStagingRequested>(_onStageRequested);
    on<ScannerEventItemQuantityIncrement>(_onStockItemIncrement);
    on<ScannerEventItemQuantityDecrement>(_onStockItemDecrement);
    on<ScannerEventAddStockToDatabaseRequested>(_onAddStockToDatabaseRequested);
  }

  void _toggleScanner(
      ScannerEventScannerToggleRequested event, Emitter<ScannerState> emit) {
    emit(ScannerStateNormal(
      items: state.items,
      showScannerWidget: !state.showScannerWidget,
    ));
  }

  Future<void> _onBarcodeScanned(
      ScannerEventBarcodeScanned event, Emitter<ScannerState> emit) async {
    if (event.barcodeId != null) {
      if (state.items.any(
        (element) => element.item.barcodeId == event.barcodeId,
      )) return;
      emit(ScannerStateLoading(
        items: state.items,
        showScannerWidget: state.showScannerWidget,
        inputRequestingItem: state.inputRequestingItem,
        scannedPotentialItems: state.scannedPotentialItems,
      ));
      List<ScannedBarcodeItem>? results =
          await _barcodeRepository.getItems(event.barcodeId ?? '');

      if (results == null || results.isEmpty) {
        emit(
          ScannerStateUserInput(
            items: state.items,
            inputRequestingItem:
                ScannedBarcodeItem(name: null, barcodeId: event.barcodeId),
          ),
        );
      } else if (results.length == 1) {
        add(ScannerEventMakeChoice(chosenItem: results[0]));
      } else {
        emit(ScannerStateScannedItemSelector(
          items: state.items,
          potentialScannedItems: results,
        ));
      }
    }
  }

  void _onChoiceMade(ScannerEventMakeChoice event, Emitter<ScannerState> emit) {
    if (event.chosenItem.anyNull()) {
      emit(ScannerStateUserInput(
        items: state.items,
        inputRequestingItem: event.chosenItem,
      ));
    } else {
      add(ScannerEventItemStagingRequested(item: event.chosenItem));
    }
  }

  Future<void> _onStageRequested(ScannerEventItemStagingRequested event,
      Emitter<ScannerState> emit) async {
    List<StockItem> newItems = [...state.items];
    newItems.add(
      StockItem(
        item: event.item,
        expDateController: TextEditingController(),
        mfgDateController: TextEditingController(),
        costController: TextEditingController(),
      ),
    );
    if (!event.item.foundLocally) {
      emit(ScannerStateLoading(
        items: state.items,
        showScannerWidget: state.showScannerWidget,
        inputRequestingItem: state.inputRequestingItem,
        scannedPotentialItems: state.scannedPotentialItems,
      ));

      await _masterDBHandler.addMedicine(
        barcodeId: event.item.barcodeId!,
        medSaltName: event.item.name!,
        manufacturer: event.item.manufacturer!,
        medType: event.item.type!,
        mrp: event.item.mrp!,
      );

      _barcodeRepository.addItemToLocalCopy(event.item);
    }

    emit(ScannerStateNormal(
      items: newItems,
      showScannerWidget: state.showScannerWidget,
    ));
  }

  void _onStockItemIncrement(
      ScannerEventItemQuantityIncrement event, Emitter<ScannerState> emit) {
    List<StockItem> newitems = [...state.items];
    newitems[event.changedItemIdx] = StockItem(
      item: newitems[event.changedItemIdx].item,
      quantity: newitems[event.changedItemIdx].quantity + 1,
      expDateController: newitems[event.changedItemIdx].expDateController,
      mfgDateController: newitems[event.changedItemIdx].mfgDateController,
      costController: newitems[event.changedItemIdx].costController,
    );
    emit(ScannerStateNormal(
      items: newitems,
      showScannerWidget: state.showScannerWidget,
    ));
  }

  void _onStockItemDecrement(
      ScannerEventItemQuantityDecrement event, Emitter<ScannerState> emit) {
    if (state.items[event.changedItemIdx].quantity <= 1) return;

    List<StockItem> newitems = [...state.items];
    newitems[event.changedItemIdx] = StockItem(
      item: newitems[event.changedItemIdx].item,
      quantity: newitems[event.changedItemIdx].quantity - 1,
      expDateController: newitems[event.changedItemIdx].expDateController,
      mfgDateController: newitems[event.changedItemIdx].mfgDateController,
      costController: newitems[event.changedItemIdx].costController,
    );
    emit(ScannerStateNormal(
      items: newitems,
      showScannerWidget: state.showScannerWidget,
    ));
  }

  Future<void> _onAddStockToDatabaseRequested(
      ScannerEventAddStockToDatabaseRequested event,
      Emitter<ScannerState> emit) async {
    try {
      for (var stockItem in state.items) {
        if (stockItem.expDateController.text.isEmpty ||
            stockItem.mfgDateController.text.isEmpty ||
            stockItem.costController.text.isEmpty) {
          throw 'Error something empty';
        }
      }

      Map<Shipment, int> param = {};
      for (StockItem stockItem in state.items) {
        param[Shipment(
          mfgDate: DateFormat(kDefaultDateFormat)
              .parse(stockItem.mfgDateController.text),
          expDate: DateFormat(kDefaultDateFormat)
              .parse(stockItem.expDateController.text),
          costPrice: double.parse(stockItem.costController.text),
          barcodeId: stockItem.item.barcodeId!,
        )] = stockItem.quantity;
      }

      emit(ScannerStateLoading(
        items: state.items,
        showScannerWidget: state.showScannerWidget,
        inputRequestingItem: state.inputRequestingItem,
        scannedPotentialItems: state.scannedPotentialItems,
      ));

      final bool isSuccess =
          await _pharmacyDataRepository.addIncomingStock(param);

      if (isSuccess) {
        emit(const ScannerStateNormal(items: [], showScannerWidget: false));
      } else {
        emit(ScannerStateNormal(
          items: state.items,
          showScannerWidget: state.showScannerWidget,
        ));
      }
    } catch (e) {
      log('ERROR: $e');
      emit(ScannerStateNormal(
        items: state.items,
        showScannerWidget: state.showScannerWidget,
      ));
    }
  }
}

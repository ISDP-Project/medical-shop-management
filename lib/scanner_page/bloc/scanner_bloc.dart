import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:barcode_repository/barcode_repository.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final PharmacyDataRepository _pharmacyDataRepository;
  final BarcodeRepository _barcodeRepository;
  ScannerBloc({
    required BarcodeRepository barcodeRepository,
    required PharmacyDataRepository pharmacyDataRepository,
  })  : _barcodeRepository = barcodeRepository,
        _pharmacyDataRepository = pharmacyDataRepository,
        super(const ScannerStateInitial()) {
    on<ScannerEventScannerToggleRequested>(_toggleScanner);
    on<ScannerEventBarcodeScanned>(_onBarcodeScanned);
    on<ScannerEventMakeChoice>(_onChoiceMade);
    on<ScannerEventItemStagingRequested>(_onStageRequested);
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
    List<ScannedBarcodeItem> newItems = [...state.items];
    newItems.add(event.item);
    if (!event.item.foundLocally) {
      emit(ScannerStateLoading(
        items: state.items,
        showScannerWidget: state.showScannerWidget,
        inputRequestingItem: state.inputRequestingItem,
        scannedPotentialItems: state.scannedPotentialItems,
      ));

      await _pharmacyDataRepository.addGlobalMedicine(
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
}

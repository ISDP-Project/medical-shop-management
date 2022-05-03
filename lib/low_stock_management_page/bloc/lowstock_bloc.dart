import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

part 'lowstock_event.dart';
part 'lowstock_state.dart';

class LowStockBloc extends Bloc<LowStockEvent, LowStockState> {
  final PharmacyDataRepository _pharmacyDataRepository;
  // List<int> changedIds = [];
  LowStockBloc({
    required pharmacyDataRepository,
  })  : _pharmacyDataRepository = pharmacyDataRepository,
        super(const LowStockStateInitial()) {
    on<LowStockRequestedDataLoad>(_onDataLoadRequested);
    on<LowStockRequestedSortByName>(_onNameSortRequested);
    on<LowStockRequestedSortByQty>(_onQtySortRequested);
    on<LowStockRequestedSettingChange>(_onSettingChanged);
    on<LowStockSettingsSaveRequested>(_onSettingsSaved);
  }

  Future<void> _onDataLoadRequested(
      LowStockRequestedDataLoad event, Emitter<LowStockState> emit) async {
    emit(const LowStockStateLoading());
    final List<Medicine>? medicines =
        await _pharmacyDataRepository.getAllItems();
    if (medicines == null) {
      emit(const LowStockStateError());
    } else {
      // log(medicines.toString());
      emit(LowStockStateLoaded(medicines: medicines));
    }
  }

  void _onNameSortRequested(
      LowStockRequestedSortByName event, Emitter<LowStockState> emit) {
    if (state is LowStockStateLoaded) {
      List<Medicine> newList = [...?state.medicines];
      newList.sort((a, b) => a.name.compareTo(b.name));
      emit(LowStockStateLoaded(medicines: newList));
    }
  }

  void _onQtySortRequested(
      LowStockRequestedSortByQty event, Emitter<LowStockState> emit) {
    List<Medicine> newList = [...?state.medicines];
    newList.sort((a, b) => a.quantity.compareTo(b.quantity));
    emit(LowStockStateLoaded(medicines: newList));
  }

  void _onSettingChanged(
      LowStockRequestedSettingChange event, Emitter<LowStockState> emit) {
    List<int> newChangedIds = [...?state.changedIds];

    if (newChangedIds.contains(event.medicine.barcodeId)) {
      newChangedIds.remove(event.medicine.barcodeId);
      log('REMOVED');
    } else {
      newChangedIds.add(event.medicine.barcodeId);
      log('ADDED');
    }

    emit(LowStockStateLoaded(
      medicines: state.medicines,
      changedIds: newChangedIds,
    ));
  }

  Future<void> _onSettingsSaved(
      LowStockSettingsSaveRequested event, Emitter<LowStockState> emit) async {
    if (state.changedIds?.isEmpty ?? true) return;
    emit(LowStockStateLoading(
      medicines: state.medicines,
      changedIds: state.changedIds,
    ));
    await _pharmacyDataRepository.updateNotificationSettings(
        state.changedIds!, state.medicines!);
    add(const LowStockRequestedDataLoad());
  }
}

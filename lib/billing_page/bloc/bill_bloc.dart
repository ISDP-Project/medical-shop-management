import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  final PharmacyDataRepository _pharmacyDataRepository;
  BillBloc({required pharmacyDataRepository})
      : _pharmacyDataRepository = pharmacyDataRepository,
        super(const BillStateInitial()) {
    on<BillEventLoadRequested>(_onLoadRequested);
    on<BillEventItemStagedIncrement>(_onStagedIncrementRequested);
    on<BillEventItemStagedDecrement>(_onStagedDecrementRequested);
    on<BillEventItemAdditionRequested>(_onItemAdditionToBillRequested);
    on<BillEventClearBillRequested>(_onBillClearRequested);
    on<BillEventBillGenerationRequested>(_onBillGenerationRequested);
  }

  Future<void> _onLoadRequested(
      BillEventLoadRequested event, Emitter<BillState> emit) async {
    emit(const BillStateLoading());
    final List<Medicine>? medicines =
        await _pharmacyDataRepository.getAllItems();

    if (medicines == null) {
      emit(const BillStateError());
    } else {
      Map<Medicine, int> stagedItems = {};
      for (final medicine in medicines) {
        stagedItems[medicine] = 0;
      }
      emit(BillStateLoaded(
        medicines: medicines,
        stagedItems: stagedItems,
      ));
    }
  }

  void _onStagedIncrementRequested(
      BillEventItemStagedIncrement event, Emitter<BillState> emit) {
    if (event.medicine.quantity -
            (state.itemsInBill?[event.medicine] ?? 0) -
            (state.stagedItems![event.medicine] ?? 0) >
        0) {
      Map<Medicine, int> newStagedItems = {...?state.stagedItems};
      newStagedItems[event.medicine] =
          (newStagedItems[event.medicine] ?? 0) + 1;
      emit(BillStateLoaded(
        medicines: state.medicines!,
        itemsInBill: state.itemsInBill,
        stagedItems: newStagedItems,
      ));
    }
  }

  void _onStagedDecrementRequested(
      BillEventItemStagedDecrement event, Emitter<BillState> emit) {
    if (state.stagedItems![event.medicine]! > 0) {
      Map<Medicine, int> newStagedItems = {...?state.stagedItems};
      newStagedItems[event.medicine] =
          (newStagedItems[event.medicine] ?? 0) - 1;
      emit(BillStateLoaded(
        medicines: state.medicines!,
        itemsInBill: state.itemsInBill,
        stagedItems: newStagedItems,
      ));
    }
  }

  void _onItemAdditionToBillRequested(
      BillEventItemAdditionRequested event, Emitter<BillState> emit) {
    Map<Medicine, int> newItemsInBill = {...?state.itemsInBill};
    Map<Medicine, int> stagedItems = {...?state.stagedItems};
    for (final Medicine medicine in state.medicines ?? []) {
      if (stagedItems[medicine] != 0) {
        newItemsInBill[medicine] =
            (newItemsInBill[medicine] ?? 0) + stagedItems[medicine]!;

        stagedItems[medicine] = 0;
      }
    }

    emit(BillStateLoaded(
      medicines: state.medicines!,
      stagedItems: stagedItems,
      itemsInBill: newItemsInBill,
    ));
  }

  void _onBillClearRequested(
      BillEventClearBillRequested event, Emitter<BillState> emit) {
    Map<Medicine, int> stagedItems = {};
    for (final Medicine medicine in state.medicines ?? []) {
      stagedItems[medicine] = 0;
    }

    emit(BillStateLoaded(
      medicines: state.medicines!,
      stagedItems: stagedItems,
    ));
  }

  Future<void> _onBillGenerationRequested(
      BillEventBillGenerationRequested event, Emitter<BillState> emit) async {
    if (state.itemsInBill == null || state.itemsInBill!.isEmpty) return;

    emit(BillStateLoading(
      medicines: state.medicines,
      itemsInBill: state.itemsInBill,
      stagedItems: state.stagedItems,
    ));

    try {
      await _pharmacyDataRepository.removeMultipleQuantities(
        items: state.itemsInBill ?? {},
      );
      add(const BillEventLoadRequested());
    } catch (error) {
      emit(const BillStateError());
    }
  }
}

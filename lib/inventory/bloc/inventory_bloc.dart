import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc(pharmacyDataRepository)
      : _pharmacyDataRepository = pharmacyDataRepository,
        super(const InventoryInitial()) {
    on<InventoryEventLoadRequested>(_onLoadRequested);
  }

  final PharmacyDataRepository _pharmacyDataRepository;

  Future<void> _onLoadRequested(
      InventoryEventLoadRequested event, Emitter<InventoryState> emit) async {
        emit(const InventoryStateLoading());

    List<Medicine>? medicines = await _pharmacyDataRepository.getAllItems();
    log(medicines.toString());

    if (medicines == null) {
      emit(const InventoryStateError());
    } else {
      emit(InventoryStateLoaded(medicines));
    }
  }
}

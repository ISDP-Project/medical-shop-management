part of 'lowstock_bloc.dart';

abstract class LowStockEvent extends Equatable {
  const LowStockEvent();

  @override
  List<Object> get props => [];
}

class LowStockRequestedDataLoad extends LowStockEvent {
  const LowStockRequestedDataLoad();
}

class LowStockRequestedSortByName extends LowStockEvent {
  const LowStockRequestedSortByName();
}

class LowStockRequestedSortByQty extends LowStockEvent {
  const LowStockRequestedSortByQty();
}

// class LowStockRequestedDelete extends LowStockEvent {
//   const LowStockRequestedDelete(final List<Medicine> toBeDeletedMedicines);
// }

class LowStockRequestedSettingChange extends LowStockEvent {
  const LowStockRequestedSettingChange(this.medicine);

  final Medicine medicine;
}

class LowStockSettingsSaveRequested extends LowStockEvent {
  const LowStockSettingsSaveRequested();
}

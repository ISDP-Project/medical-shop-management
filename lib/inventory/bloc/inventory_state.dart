part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState(this.medicines);

  final List<Medicine>? medicines;
  
  @override
  List<Object?> get props => [medicines];
}

class InventoryInitial extends InventoryState {
  const InventoryInitial() : super(null);
}

class InventoryStateInitial extends InventoryState {
  const InventoryStateInitial() : super(null);
}

class InventoryStateLoading extends InventoryState {
  const InventoryStateLoading() : super(null);
}

class InventoryStateError extends InventoryState {
  const InventoryStateError() : super(null);
}

class InventoryStateLoaded extends InventoryState {
  const InventoryStateLoaded(List<Medicine> medicines) : super(medicines);
}
part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class InventoryEventLoadRequested extends InventoryEvent {
  const InventoryEventLoadRequested();
}

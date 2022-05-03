part of 'bill_bloc.dart';

abstract class BillEvent extends Equatable {
  const BillEvent();

  @override
  List<Object> get props => [];
}

class BillEventLoadRequested extends BillEvent {
  const BillEventLoadRequested();
}

class BillEventItemStagedIncrement extends BillEvent {
  final Medicine medicine;
  const BillEventItemStagedIncrement(this.medicine);
}

class BillEventItemStagedDecrement extends BillEvent {
  final Medicine medicine;
  const BillEventItemStagedDecrement(this.medicine);
}

class BillEventItemAdditionRequested extends BillEvent {
  const BillEventItemAdditionRequested();
}

class BillEventClearBillRequested extends BillEvent {
  const BillEventClearBillRequested();
}

class BillEventBillGenerationRequested extends BillEvent {
  const BillEventBillGenerationRequested();
}

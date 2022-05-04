part of 'bill_history_bloc.dart';

abstract class BillHistoryEvent extends Equatable {
  const BillHistoryEvent();

  @override
  List<Object> get props => [];
}

class BillHistoryEventLoadRequested extends BillHistoryEvent {
  const BillHistoryEventLoadRequested();
}

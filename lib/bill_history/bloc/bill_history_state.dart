part of 'bill_history_bloc.dart';

abstract class BillHistoryState extends Equatable {
  const BillHistoryState(this.bills);

  final List<Bill>? bills;

  @override
  List<Object?> get props => [bills];
}

class BillHistoryStateInitial extends BillHistoryState {
  const BillHistoryStateInitial() : super(null);
}

class BillHistoryStateLoading extends BillHistoryState {
  const BillHistoryStateLoading() : super(null);
}

class BillHistoryStateError extends BillHistoryState {
  const BillHistoryStateError() : super(null);
}

class BillHistoryStateLoaded extends BillHistoryState {
  const BillHistoryStateLoaded(List<Bill> bills) : super(bills);
}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bill_history_event.dart';
part 'bill_history_state.dart';

class BillhistoryBloc extends Bloc<BillhistoryEvent, BillhistoryState> {
  BillhistoryBloc() : super(BillhistoryInitial()) {
    on<BillhistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

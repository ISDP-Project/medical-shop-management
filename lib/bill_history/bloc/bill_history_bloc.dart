import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_data_repository/pharmacy_data_repository.dart';

part 'bill_history_event.dart';
part 'bill_history_state.dart';

class BillHistoryBloc extends Bloc<BillHistoryEvent, BillHistoryState> {
  BillHistoryBloc(PharmacyDataRepository pharmacyDataRepository)
      : _pharmacyDataRepository = pharmacyDataRepository,
        super(const BillHistoryStateInitial()) {
    on<BillHistoryEventLoadRequested>(_onLoadRequested);
  }

  final PharmacyDataRepository _pharmacyDataRepository;

  Future<void> _onLoadRequested(BillHistoryEventLoadRequested event,
      Emitter<BillHistoryState> emit) async {
        emit(const BillHistoryStateLoading());
        List<Bill>? bills = await _pharmacyDataRepository.getAllBills();
        if (bills == null) {
          emit(const BillHistoryStateError());
        } else {
          bills.sort((a, b) => -1 * a.date.compareTo(b.date),);
          emit(BillHistoryStateLoaded(bills));
        }
      }
}

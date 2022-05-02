part of 'lowstock_bloc.dart';

enum LoadStatus { loading, error, loaded }

@immutable
abstract class LowStockState extends Equatable {
  const LowStockState(this.medicines, this.loadStatus, this.changedIds);

  final List<Medicine>? medicines;
  final LoadStatus? loadStatus;
  final List<int>? changedIds;

  @override
  List<Object?> get props => [loadStatus, changedIds, medicines];
}

class LowStockStateInitial extends LowStockState {
  const LowStockStateInitial() : super(null, null, null);
}

class LowStockStateLoading extends LowStockState {
  const LowStockStateLoading({
    List<Medicine>? medicines,
    List<int>? changedIds,
  }) : super(medicines, LoadStatus.loading, changedIds);
}

class LowStockStateError extends LowStockState {
  const LowStockStateError() : super(null, LoadStatus.error, null);
}

class LowStockStateLoaded extends LowStockState {
  const LowStockStateLoaded(
      {required List<Medicine>? medicines, List<int> changedIds = const []})
      : super(medicines, LoadStatus.loaded, changedIds);
}
